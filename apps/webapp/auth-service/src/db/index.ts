import { Client } from 'pg';

let client;

const {
  POSTGRES_USER = 'postgres',
  POSTGRES_HOST = 'localhost',
  POSTGRES_DB = 'mantra',
  POSTGRES_PASSWORD = 'password',
} = process.env;

export const getClient = async () => {
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

  await client.connect();

  return client;
};
