"use strict";

var dotenv = require('dotenv');

var express = require('express');

var path = require('path');

var cors = require('cors');

var _require = require('child_process'),
    spawn = _require.spawn;

var client = require('./db')();

console.log(__dirname);
dotenv.config({
  path: path.resolve(__dirname, '../../.env')
});
var STREAM_PORT = process.env.STREAM_PORT || 3000;
var app = express();
var jobs = [];

var runJob = function runJob(userId, row) {
  return function (cb) {
    var command = '/test-scripts/test.sh';
    var child = spawn('bash', [__dirname + command]);
    child.stdout.on('data', function (data) {
      console.log('data here', data.toString()); // Insertion of logs

      client.query('INSERT INTO public.log(build_id, log, command) values ($1, $2, $3) RETURNING *', [row.id, data.toString(), command], function (errLog, dbResLog) {// console.log(errLog, dbResLog);
      });
    });
    child.stderr.on('data', function (data) {
      console.log(data.toString());
    });
    child.on('close', function (code) {
      console.log("child process exited with code ".concat(code)); // Update the status of the build

      client.query('UPDATE public.build set code=$1 where id=$2', [code, row.id], function (errLog, dbResLog) {// console.log(errLog, dbResLog);
      });
      cb();
    });
  };
};

var queueRunner = function queueRunner() {
  if (jobs.length) {
    var job = jobs.shift();
    job(function () {
      queueRunner();
    });
  }
};

var queueJob = function queueJob(userId, row) {
  jobs.push(runJob(userId, row));
  queueRunner();
};

app.use(cors());
app.get('/provision', function (req, res) {
  var userId = req.query.userId; // Check if there was a build

  client.query('SELECT FROM public.build where user_id=$1', [userId], function (err, dbRes) {
    if (dbRes.rows.length) {
      return res.send({
        status: 'Have already provisioned',
        redirect: 'https://gideon.cloudcomputer.dev'
      });
    } // Create a build


    client.query('INSERT INTO public.build(user_id, code) values ($1, 99) RETURNING *', [userId], function (err, dbRes) {
      console.log(err);
      var row = dbRes.rows[0];
      queueJob(userId, row);
      res.send({
        status: 'provisioning',
        build: row
      });
    });
  });
});
console.log('listening @port', STREAM_PORT);
app.listen(STREAM_PORT);
