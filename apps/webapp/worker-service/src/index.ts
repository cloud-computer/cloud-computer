import { spawn } from 'child_process';
import * as dotenv from 'dotenv';
import { resolve } from 'path';
import * as redis from 'redis';

import { getClient } from './db';

dotenv.config({ path: resolve(__dirname, '../../.env') });

const {
  REDIS_HOST = 'redis',
  REDIS_PORT = 6379
} = process.env;

const client = getClient();

const subscriber = redis.createClient({
  host: REDIS_HOST,
  port: REDIS_PORT as any,
});

const logs = [];

const runLogSaver = () => {
  if (logs.length) {
    let log = logs.shift();
    log(() => {
      /** add delay */
      setTimeout(() => {
        runLogSaver();
      }, 500);
    });
  }
};

const saveLogs = (fn) => {
  logs.push(fn);
  runLogSaver();
};
/** In memory queue for jobs **/
const jobs = [];

const runJob = (userId, row, cloudUser) => {
  return () => {
    const command = '/scripts/run.sh';
    const child = spawn('bash', [ __dirname + command, cloudUser ]);

    child.stdout.on('data', async (data) => {
      console.log(data.toString());
      /** logs all stdout **/
      saveLogs(async (cb) => {
        await client.query(
          'INSERT INTO public.log(build_id, log, command) values ($1, $2, $3) RETURNING *',
          [ row.id, data.toString(), command ]);
        cb();
      });
    });

    child.stderr.on('data', async (data) => {
      /** logs all stderr **/
      /*
          await client.query(
              'INSERT INTO public.log(build_id, log, command) values ($1, $2, $3) RETURNING *',
              [row.id, data.toString(), command]);
      */
    });

    child.on('close', async (code) => {
      /** Update the build status **/
      saveLogs(async (cb) => {
        await client.query(
          'UPDATE public.build set code=$1 where id=$2',
          [ code, row.id ]);
        cb();
      });
    });

  };
};

/** Queue runner **/
const queueRunner = () => {
  if (jobs.length) {
    let job = jobs.shift();
    job(() => {
      queueRunner();
    });
  }
};

/** Queue job then try to run job **/
const queueJob = (userId, row, cloudUser) => {
  jobs.push(runJob(userId, row, cloudUser));
  queueRunner();
};

/** Listen to jobs **/
subscriber.on('message', function (channel, message) {
  console.log("Message '" + message + "' on channel '" + channel + "' arrived!");
  if (channel === 'build:provision') {
    const { userId, row, cloudUser } = JSON.parse(message);
    queueJob(userId, row, cloudUser);
  }
});

/** Listen to this jobs channel**/
subscriber.subscribe('build:provision');
