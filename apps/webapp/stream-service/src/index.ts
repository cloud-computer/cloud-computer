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

app.get('/provision', async ({ query }, res) => {
  /** This should be provided by the token **/
  const { userId } = query;

  try {
    const getUser = await client.query('SELECT * FROM public.user where id=$1', [userId]);
    const [existingUser] = getUser.rows;

    const getBuild = await client.query('SELECT * FROM public.build where user_id=$1', [userId]);
    const [existingBuild] = getBuild.rows;

    if (existingBuild) {
      return res.send({
        status: 'Have already provisioned',
        redirect: existingUser.cloud_url
      })
    }

    /** If there is no existing build then create one **/
    const createBuild = await client.query('INSERT INTO public.build(user_id, code) values ($1, 99) RETURNING *', [userId]);
    const createdBuild = createBuild.rows;

    /** Queue the job **/
    publisher.publish('build:provision', JSON.stringify({
      userId,
      row: createdBuild,
      cloudUser: existingUser.cloud_user
    }));

    /** Return the build for reference **/
    res.send({
      status: 'provisioning',
      build: createdBuild,
    });
  } catch (e) {
    return res.status(500).send({
      status: 'Oops',
      message: e.message
    });
  }
});

app.listen(3000);
