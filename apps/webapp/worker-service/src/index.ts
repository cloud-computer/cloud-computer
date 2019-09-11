import { spawn } from 'child_process';
import * as redis from 'redis';

import { getClient } from './db';

const {
  CLOUD_COMPUTER_REPOSITORY,
  REDIS_HOST,
  REDIS_PORT,
} = process.env;

const client = getClient();

const subscriber = redis.createClient({
  host: REDIS_HOST || 'redis',
  port: REDIS_PORT as any || 6379,
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
    const child = spawn('bash', ['-e', 'yarn create:cloud-computer'], { env: { CLOUD_COMPUTER_HOST_ID: cloudUser }, cwd: CLOUD_COMPUTER_REPOSITORY });

    child.stdout.on('data', async (data) => {
      saveLogs(async (cb) => {
        await client.query(
          'INSERT INTO public.log(build_id, log, command) values ($1, $2, $3) RETURNING *',
          [row.id, data.toString(), 'yarn create:cloud-computer']);
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
          [code, row.id]);
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

/** Listen to jobs **/
subscriber.on('message', function (channel, message) {
  console.log("Message '" + message + "' on channel '" + channel + "' arrived!");
  if (channel === 'build:provision') {
    const { userId, row, cloudUser } = JSON.parse(message);
    jobs.push(runJob(userId, row, cloudUser));
    queueRunner();
  }
});

/** Listen to this jobs channel**/
subscriber.subscribe('build:provision');
