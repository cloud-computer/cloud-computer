import dotenv from 'dotenv';
import path from 'path';
import {spawn} from 'child_process';
import db from './db';
import redis from 'redis';

/** Get the env **/
dotenv.config({path: path.resolve(__dirname, '../../.env')});

/** Get all environments **/
const {
    REDIS_HOST,
    REDIS_PORT
} = process.env;

/** Initialize db **/
const client = db();

/** Initialize redis **/
const subscriber = redis.createClient({
    host : REDIS_HOST ? REDIS_HOST : '127.0.0.1',
    port : REDIS_PORT ? REDIS_PORT : 6379
});

/** In memory queue for jobs **/
const jobs = [];

const runJob = (userId, row) => {
    return (cb) => {
        const command = '/test-scripts/test.sh';
        const child = spawn('bash', [__dirname + command]);

        child.stdout.on('data', async (data) => {
            /** logs all stdout **/
            await client.query(
                'INSERT INTO public.log(build_id, log, command) values ($1, $2, $3) RETURNING *',
                [row.id, data.toString(), command]);
        });

        child.stderr.on('data', async(data) => {
            /** logs all stderr **/
            await client.query(
                'INSERT INTO public.log(build_id, log, command) values ($1, $2, $3) RETURNING *',
                [row.id, data.toString(), command]);
        });

        child.on('close', async (code) => {
            /** Update the build status **/
            await client.query(
                'UPDATE public.build set code=$1 where id=$2',
                [code, row.id]);
            /** Tell the queue runner if its done **/
            cb();
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
const queueJob = (userId, row) => {
    jobs.push(runJob(userId, row));
    queueRunner();
};

/** Listen to jobs **/
subscriber.on('message', function(channel, message) {
    console.log("Message '" + message + "' on channel '" + channel + "' arrived!");
    if(channel === 'build:provision') {
        const {userId,row} = JSON.parse(message);
        queueJob(userId, row);
    }
});

/** Listen to this jobs channel**/
subscriber.subscribe('build:provision');
