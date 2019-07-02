const dotenv = require('dotenv');
const express = require('express');
const path = require('path');
const cors = require('cors');
const {spawn} = require('child_process');
const client = require('./db')();

dotenv.config({path: path.resolve(__dirname, '../.env')});

const {
    STREAM_PORT
} = process.env;

const app = express();

const jobs = [];
const runJob = (userId, row) => {
    return (cb) => {
        const command = '/test-scripts/test.sh';
        const child = spawn('bash', [__dirname + command]);
        child.stdout.on('data', data => {
            console.log('data here', data.toString());
            // Insertion of logs
            client.query(
                'INSERT INTO public.log(build_id, log, command) values ($1, $2, $3) RETURNING *',
                [row.id, data.toString(), command],
                (errLog, dbResLog) => {
                    // console.log(errLog, dbResLog);
                });
        });

        child.stderr.on('data', data => {
            console.log(data.toString());
        });

        child.on('close', (code) => {
            console.log(`child process exited with code ${code}`);
            // Update the status of the build
            client.query(
                'UPDATE public.build set code=$1 where id=$2',
                [code, row.id],
                (errLog, dbResLog) => {
                    // console.log(errLog, dbResLog);
                });
            cb();
        });

    };
};
const queueRunner = () => {
    if (jobs.length) {
        let job = jobs.shift();
        job(() => {
            queueRunner();
        });
    }
};
const queueJob = (userId, row) => {
    jobs.push(runJob(userId, row));
    queueRunner();
};

app.use(cors());

app.get('/provision', (req, res) => {
    const userId = req.query.userId;
    // Check if there was a build
    client.query(
        'SELECT FROM public.build where user_id=$1',
        [userId],
        (err, dbRes) => {
            if(dbRes.rows.length) {
                return res.send({
                    status : 'Have already provisioned',
                    redirect : 'https://gideon.cloudcomputer.dev'
                })
            }

            // Create a build
            client.query(
                'INSERT INTO public.build(user_id, code) values ($1, 99) RETURNING *',
                [userId],
                (err, dbRes) => {
                    console.log(err);
                    const row = dbRes.rows[0];
                    queueJob(userId, row);
                    res.send({status: 'provisioning', build: row});
                });
        });
});

console.log('listening @port', STREAM_PORT);
app.listen(STREAM_PORT);