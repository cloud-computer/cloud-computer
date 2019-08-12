import * as dotenv from 'dotenv';
import { resolve } from 'path';
import { Client } from 'pg';

dotenv.config({ path: resolve(__dirname, '../../.env') });

let client;

const {
  POSTGRES_USER = 'postgres',
  POSTGRES_HOST = 'localhost',
  POSTGRES_DB = 'mantra',
  POSTGRES_PASSWORD = 'password'
} = process.env;

export const getClient = () => {
  if (client) {
    return client;
  }

  client = new Client({
    user: POSTGRES_USER,
    host: POSTGRES_HOST,
    database: POSTGRES_DB,
    password: POSTGRES_PASSWORD,
    port: 5432
  });

  client.connect((err) => {
    if (err) {
      console.error('connection error', err.stack);
    } else {
      console.log('connected');
    }
  });

  return client;
};
