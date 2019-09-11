import * as bcrypt from 'bcryptjs';
import * as express from 'express';
import * as jwt from 'jsonwebtoken';
import * as passport from 'passport';
import * as url from 'url';

import { getClient } from '../db';

export const router = express.Router();

const client = getClient();

const {
  JSON_SECRET,
  REACT_APP
} = process.env;

const googleAuth = passport.authenticate('google', { scope: ['profile', 'email'] });
const githubAuth = passport.authenticate('github');

const errorHandler = async (err, _req, res, _next) => {
  // cancel any in progress queries
  await client.query('ROLLBACK');

  console.log(err.name);
  if (err.name === 'TokenError') {
    return res.redirect('/auth/google');
  } else {
    return res.status(500).json({ error: err.message });
  }
}

router.use(errorHandler);

const jwtEncrypt = ({ id, first_name, last_name }) => jwt.sign(
  {
    firstname: first_name,
    lastname: last_name,
    'https://hasura.io/jwt/claims': {
      'x-hasura-allowed-roles': ['admin'],
      'x-hasura-default-role': 'admin',
      'x-hasura-user-id': id,
    }
  },
  JSON_SECRET
);

router.get('/google', googleAuth);
router.get('/google/callback', googleAuth, async ({ user }, res) => {
  /** If email exist then use the email for username if not then use id **/
  const id = user.emails && user.emails.length
    ? user.emails[0].value
    : user.id;

  await client.query('BEGIN');

  /** Check if the user exist **/
  const getUser = await client.query('SELECT * FROM public.user where google_id=$1', [user.id]);

  if (getUser.rows.length) {
    const [existingUser] = getUser.rows;
    return res.redirect(url.format({
      pathname: REACT_APP,
      query: {
        token: jwtEncrypt(existingUser),
        firstname: existingUser.first_name,
        lastname: existingUser.last_name,
      }
    }));
  }

  /** If not then create the user **/
  const createUser = await client.query(
    'INSERT INTO public.user(username,password,first_name,last_name, google_id, role) values ($1,$2,$3,$4,$5,$6) RETURNING *',
    [
      id,
      user.id,
      user.name.givenName,
      user.name.familyName,
      user.id,
      'user'
    ]);

  await client.query('COMMIT');

  const [createdUser] = createUser.rows;
  return res.redirect(url.format({
    pathname: REACT_APP,
    query: {
      token: jwtEncrypt(createdUser),
      firstname: createdUser.first_name,
      lastname: createdUser.last_name,
    }
  }));
});

router.get('/github', githubAuth);
router.get('/github/callback', githubAuth, async ({ user }, res) => {
  /** If email exist then use the email for username if not then use id **/
  const id = user.emails && user.emails.length
    ? user.emails[0].value
    : user.id;

  await client.query('BEGIN');

  /** Check if the user exist **/
  const getUser = await client.query('SELECT * FROM public.user where github_id=$1', [user.id]);

  if (getUser.rows.length) {
    const [existingUser] = getUser.rows;
    return res.redirect(url.format({
      pathname: REACT_APP,
      query: {
        token: jwtEncrypt(existingUser),
        firstname: existingUser.first_name,
        lastname: existingUser.last_name,
      }
    }));
  }

  /** If not then create the user **/
  const createUser = await client.query(
    'INSERT INTO public.user(username,password,first_name,last_name, github_id, role) values ($1,$2,$3,$4,$5,$6) RETURNING *',
    [
      id,
      user.id,
      user.displayName.split(' ')[0],
      user.displayName.split(' ')[1],
      user.id,
      'user'
    ],
  );

  await client.query('COMMIT');

  const [createdUser] = createUser.rows;
  return res.redirect(url.format({
    pathname: REACT_APP,
    query: {
      token: jwtEncrypt(createdUser),
      firstname: createdUser.first_name,
      lastname: createdUser.last_name,
    }
  }));
});

router.post('/login', async function (req, res) {
  const getUser = await client.query('SELECT * FROM public.user WHERE username=$1', [req.body.username]);
  const [existingUser] = getUser.rows.shift();

  if (!existingUser) {
    res.status(404).send({
      message: 'Hmm. We cant find your username'
    });
  }

  const passwordsMatch = bcrypt.compareSync(req.body.password, existingUser.password);
  if (!passwordsMatch) {
    return res.status(401).send({
      message: 'Password does not match.'
    });
  }

  res.send({
    token: jwtEncrypt(existingUser),
    firstname: existingUser.first_name,
    lastname: existingUser.last_name,
  });
});

router.post('/register', async function ({ body }, res) {
  const { username, password, firstname, lastname, role = 'user' } = body;
  const newUser = {
    username,
    password: bcrypt.hashSync(password, 10),
    firstname,
    lastname,
    role,
  };

  await client.query('BEGIN');

  const createUser = await client.query(
    'INSERT INTO public.user(username,password,first_name,last_name, role) values ($1,$2,$3,$4,$5) RETURNING *',
    Object.values(newUser),
  );

  await client.query('COMMIT');

  const [createdUser] = createUser.rows;
  res.send(createdUser);
});
