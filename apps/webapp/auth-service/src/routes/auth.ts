import * as bcrypt from 'bcryptjs';
import * as express from 'express';
import * as jwt from 'jsonwebtoken';
import * as passport from 'passport';
import * as url from 'url';

import { getClient } from '../db';

export const router = express.Router();

const client = getClient();

/** Get all credentials **/
const {
  JSON_SECRET,
  REACT_APP
} = process.env;

/** List all authenticate for third parties **/
const googleAuth = passport.authenticate('google', { scope: ['profile', 'email'] });
const githubAuth = passport.authenticate('github');

/** Common catcher for errors **/
const shouldAbort = (err) => {
  if (err) {
    console.error('Error in transaction', err.stack);
    client.query('ROLLBACK', (err) => {
      if (err) {
        console.error('Error rolling back client', err.stack);
      }
      // release the client back to the pool
    });
  }
  return !!err;
};

/** Utils for token **/
const jwtEncrypt = (user) => {

  /** For now make it admin just to have access **/
  return jwt.sign(
    {
      firstname: user.first_name,
      lastname: user.last_name,
      'https://hasura.io/jwt/claims': {
        'x-hasura-allowed-roles': ['admin'],
        'x-hasura-default-role': 'admin',
        'x-hasura-user-id': '' + user.id
      }
    },
    JSON_SECRET
  );
};

/**
 * GOOGLE Sign-in
 */
router.get('/google', googleAuth);
router.get('/google/callback', googleAuth, (err, req, res, next) => {
  console.log(err.name);
  if (err.name === 'TokenError') {
    console.log('error');
    return res.redirect('/auth/google');
  } else {
    // Handle other errors here
  }
  next();
}, (req, res) => {
  client.query('BEGIN', (err) => {
    if (shouldAbort(err)) return res.status(500).send('DB: ERROR');
    const { user } = req;

    /** If email exist then use the email for username if not then use id **/
    const id = user.emails && user.emails.length
      ? user.emails[0].value
      : user.id;

    /** Check if the user exist **/
    client.query(
      'SELECT * FROM public.user where google_id=$1',
      [user.id],
      (err, dbRes) => {
        if (shouldAbort(err)) {
          return res.status(500).send('DB: ERROR');
        }

        if (dbRes.rows.length) {
          const user = dbRes.rows[0];
          return res.redirect(url.format({
            pathname: REACT_APP,
            query: {
              token: jwtEncrypt(user),
              firstname: user.first_name,
              lastname: user.last_name,
            }
          }));
        }

        /** If not then create the user **/
        client.query(
          'INSERT INTO public.user(username,password,first_name,last_name, google_id, role) values ($1,$2,$3,$4,$5,$6) RETURNING *',
          [
            id,
            user.id,
            user.name.givenName,
            user.name.familyName,
            user.id,
            'user'
          ],
          (err, dbRes) => {
            if (shouldAbort(err)) {
              return res.status(500).send('DB: ERROR');
            }

            client.query('COMMIT', (err) => {
              if (shouldAbort(err)) {
                return res.status(500).send('DB: ERROR');
              }
              const user = dbRes.rows[0];
              return res.redirect(url.format({
                pathname: REACT_APP,
                query: {
                  token: jwtEncrypt(user),
                  firstname: user.first_name,
                  lastname: user.last_name,
                }
              }));
            });
          });
      }
    );
  });
});

/** Github **/
router.get('/github', githubAuth);
router.get('/github/callback', githubAuth, (err, req, res, next) => {
  console.log(err.name);
  if (err.name === 'TokenError') {
    console.log('error');
    return res.redirect('/auth/github');
  } else {
    // Handle other errors here
  }
  next();
}, (req, res) => {
  client.query('BEGIN', (err) => {
    if (shouldAbort(err)) return res.status(500).send('DB: ERROR');
    const { user } = req;

    /** If email exist then use the email for username if not then use id **/
    const id = user.emails && user.emails.length
      ? user.emails[0].value
      : user.id;

    /** Check if the user exist **/
    client.query(
      'SELECT * FROM public.user where github_id=$1',
      [user.id],
      (err, dbRes) => {
        if (shouldAbort(err)) {
          return res.status(500).send('DB: ERROR');
        }

        if (dbRes.rows.length) {
          const user = dbRes.rows[0];
          return res.redirect(url.format({
            pathname: REACT_APP,
            query: {
              token: jwtEncrypt(user),
              firstname: user.first_name,
              lastname: user.last_name,
            }
          }));
        }

        const name = user.displayName.split(' ');
        /** If not then create the user **/
        client.query(
          'INSERT INTO public.user(username,password,first_name,last_name, github_id, role) values ($1,$2,$3,$4,$5,$6) RETURNING *',
          [
            id,
            user.id,
            name[0],
            name[1],
            user.id,
            'user'
          ],
          (err, dbRes) => {
            if (shouldAbort(err)) {
              return res.status(500).send('DB: ERROR');
            }

            client.query('COMMIT', (err) => {
              if (shouldAbort(err)) {
                return res.status(500).send('DB: ERROR');
              }
              const user = dbRes.rows[0];
              return res.redirect(url.format({
                pathname: REACT_APP,
                query: {
                  token: jwtEncrypt(user),
                  firstname: user.first_name,
                  lastname: user.last_name,
                }
              }));
            });
          });
      }
    );
  });
});

/** Manual Login and Registration **/
router.post('/login', function (req, res) {
  client.query('SELECT * FROM public.user WHERE username=$1', [req.body.username], (err, dbRes) => {
    if (err) {
      res.status(401).send({
        message: 'Oh no something went wrong!'
      });
    }
    if (dbRes.rows.length) {
      const user = dbRes.rows.shift();

      return bcrypt.compare(req.body.password, user.password, function (err, match) {

        if (err) {
          return res.status(401).send({
            message: 'Cant handle the request'
          });
        }
        if (!match) {
          return res.status(403).send({
            message: 'Passwords dont match.'
          });
        }
        res.send({
          token: jwtEncrypt(user),
          firstname: user.first_name,
          lastname: user.last_name,
        });
      });
    }
    res.status(404).send({
      message: 'Hmm. We cant find your username'
    });
  });
});

router.post('/register', function (req, res) {
  const userInformation = {
    username: req.body.username,
    password: req.body.password,
    firstname: req.body.firstname,
    lastname: req.body.lastname,
    /** Todo
     * Need to have list of roles for this
     */
    role: req.body.role ? req.body.role : 'user'
  };

  bcrypt.hash(userInformation.password, 10, function (err, hash) {
    if (err) {
      return res.status(500).send('CRYPT: ERROR');
    }
    userInformation.password = hash;
    const data = Object.keys(userInformation).map((infoKey) => {
      return userInformation[infoKey];
    });

    client.query('BEGIN', (err) => {
      if (shouldAbort(err)) return res.status(500).send('DB: ERROR');
      // Insert user
      client.query(
        'INSERT INTO public.user(username,password,first_name,last_name, role) values ($1,$2,$3,$4,$5) RETURNING *',
        data,
        (err, dbRes) => {
          if (shouldAbort(err)) {
            return res.status(500).send({
              message: err.message
            });
          }

          client.query('COMMIT', (err) => {
            if (shouldAbort(err)) {
              return res.status(500).send('DB: ERROR');
            }
            res.send(dbRes.rows[0]);
          });
        });
    });
  });
});
