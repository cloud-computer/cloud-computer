import * as cors from 'cors';
import * as express from 'express';
import * as redis from 'redis';

import { getClient } from './db';

const {
  REDIS_HOST,
  REDIS_PORT,
} = process.env;

const publisher = redis.createClient({
  host: REDIS_HOST || 'redis',
  port: REDIS_PORT as any || 6379,
});

const client = getClient();

const app = express();
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
    publisher.publish('build:provision', JSON.stringify({
      userId,
      row,
      cloudUser: userInfo.rows[0].cloud_user
    }));

    /** Return the build for reference **/
    res.send({ status: 'provisioning', build: row });
  } catch (e) {
    return res.send({
      status: 'Oops',
      message: e.message
    }).status(500)
  }

});

console.log('listening @port', 3000);
app.listen(3000);
