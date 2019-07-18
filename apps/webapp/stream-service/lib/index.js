import dotenv from 'dotenv';
import express from 'express';
import path from 'path';
import cors from 'cors';
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
const publisher = redis.createClient({
    host : REDIS_HOST ? REDIS_HOST : 'redis',
    port : REDIS_PORT ? REDIS_PORT : 6379
});

const app = express();

/** Add cors **/
app.use(cors());

app.get('/provision', async (req, res) => {

    /** This should be provided by the token **/
    const userId = req.query.userId;

    try {
        const userInfo = await client.query('SELECT * FROM public.user where id=$1', [userId]);
        const foundBuild = await client.query('SELECT * FROM public.build where user_id=$1', [userId]);

        /** Check if there is an existing build **/
        if (foundBuild.rows.length) {
            return res.send({
                status: 'Have already provisioned',
                redirect: userInfo.rows[0].cloud_url
            })
        }

        /** If there is no existing build then create one **/
        const newBuild = await client.query('INSERT INTO public.build(user_id, code) values ($1, 99) RETURNING *', [userId]);

        /** Extract the new build row **/
        const row = newBuild.rows[0];

        /** Queue the job **/
        publisher.publish('build:provision',JSON.stringify({
            userId,
            row,
            cloudUser : userInfo.rows[0].cloud_user
        }));

        /** Return the build for reference **/
        res.send({status: 'provisioning', build: row});
    } catch (e) {
        return res.send({
            status: 'Oops',
            message: e.message
        }).status(500)
    }

});

console.log('listening @port', 3000);
app.listen(3000);
