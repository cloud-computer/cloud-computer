import dotenv from 'dotenv';
import express from 'express';
import path from 'path';
import cors from 'cors';
import {spawn} from 'child_process';
import db from './db';

/** Get the env **/
dotenv.config({path: path.resolve(__dirname, '../../.env')});

/** Initialize db **/
const client = db();

/** Get all environments **/
const {
    STREAM_PORT
} = process.env;

const app = express();

/** Add cors **/
app.use(cors());

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

app.get('/provision', async (req, res) => {

    /** This should be provided by the token **/
    const userId = req.query.userId;

    try {
        const foundBuild = await client.query('SELECT FROM public.build where user_id=$1', [userId]);

        /** Check if there is an existing build **/
        if (foundBuild.rows.length) {
            return res.send({
                status: 'Have already provisioned',
                redirect: 'https://gideon.cloudcomputer.dev'
            })
        }

        /** If there is no existing build then create one **/
        const newBuild = await client.query('INSERT INTO public.build(user_id, code) values ($1, 99) RETURNING *', [userId]);

        /** Extract the new build row **/
        const row = newBuild.rows[0];

        /** Queue the job **/
        queueJob(userId, row);

        /** Return the build for reference **/
        res.send({status: 'provisioning', build: row});
    } catch (e) {
        return res.send({
            status: 'Oops',
            message: e.message
        }).status(500)
    }

});

console.log('listening @port', STREAM_PORT);
app.listen(STREAM_PORT);