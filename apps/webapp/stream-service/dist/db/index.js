"use strict";

var _require = require('pg'),
    Client = _require.Client;

var dotenv = require('dotenv');

var path = require('path');

dotenv.config({
  path: path.resolve(__dirname, '../../.env')
});
var client;
/** Get all credentials **/

var _process = process,
    _process$env = _process.env,
    POSTGRES_USER = _process$env.POSTGRES_USER,
    POSTGRES_HOST = _process$env.POSTGRES_HOST,
    POSTGRES_DB = _process$env.POSTGRES_DB,
    POSTGRES_PASSWORD = _process$env.POSTGRES_PASSWORD;

module.exports = function () {
  if (client) {
    return client;
  }
  /** Intialize DB **/


  client = new Client({
    user: POSTGRES_USER || 'postgres',
    host: POSTGRES_HOST || 'localhost',
    database: POSTGRES_DB || 'mantra',
    password: POSTGRES_PASSWORD || 'password',
    port: 5432
  });
  /** Connect to the database **/

  client.connect(function (err) {
    if (err) {
      console.error('connection error', err.stack);
    } else {
      console.log('connected');
    }
  });
  return client;
};