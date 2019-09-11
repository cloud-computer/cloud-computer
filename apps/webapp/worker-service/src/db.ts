import { Client } from 'pg';

let client;

const {
  POSTGRES_USER,
  POSTGRES_HOST,
  POSTGRES_DB,
  POSTGRES_PASSWORD
} = process.env;

export const getClient = () => {
  if (client) {
    return client;
  }

  client = new Client({
    user: POSTGRES_USER || 'postgres',
    host: POSTGRES_HOST || 'localhost',
    database: POSTGRES_DB || 'mantra',
    password: POSTGRES_PASSWORD || 'password',
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
