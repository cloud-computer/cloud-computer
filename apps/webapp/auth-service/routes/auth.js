const express = require('express');
const bcrypt = require('bcryptjs');
const passport = require('passport');
const jwt = require('jsonwebtoken');
const router = express.Router();
const client = require('../db')();

/** Get all credentials **/
const {
    env: {
        JSON_SECRET,
        REACT_APP
    }
} = process;

/** List all authenticate for third parties **/
const googleAuth = passport.authenticate('google', {scope: ['profile']});

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

/**
 * GOOGLE Sign-in
 */
router.get('/google', googleAuth);
router.get('/google/callback', googleAuth, (err, req, res) => {
        if (err.name === 'TokenError') {
            res.redirect('/google');
        } else {
            // Handle other errors here
        }
    }, (req, res) => {

        client.query('BEGIN', (err) => {
            if (shouldAbort(err)) return res.status(500).send('DB: ERROR');
            // Insert user
            client.query(
                'INSERT INTO public.user(username,password,first_name,last_name, role) values ($1,$2,$3,$4,$5) RETURNING *',
                data,
                (err, dbRes) => {
                    if (shouldAbort(err)) {
                        return res.status(500).send('DB: ERROR');
                    }

                    client.query('COMMIT', (err) => {
                        if (shouldAbort(err)) {
                            return res.status(500).send('DB: ERROR');
                        }
                        res.send(dbRes.rows[0]);
                    });
                });
        });


        res.redirect(REACT_APP);
    });

/** Manual Login and Registration **/
router.post('/login', function (req, res) {
    client.query('SELECT * FROM public.user WHERE username=$1', [req.body.username], (err, dbRes) => {
        if (err) {
            return res.status(500).send('DB: ERROR');
        }
        if (dbRes.rows.length) {
            const user = dbRes.rows.shift();

            return bcrypt.compare(req.body.password, user.password, function (err) {
                if (err) {
                    return res.status(500).send('CRYPT: ERROR');
                }
                const token = jwt.sign(
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

                res.send({
                    token,
                    firstname: user.first_name,
                    lastname: user.last_name,
                });
            });
        }
        res.status(404).send('USER: NOT FOUND');
    });
});

router.post('/register', function (req, res) {
    let userInformation = {
        username: req.body.username,
        password: req.body.password,
        firstname: req.body.firstname,
        lastname: req.body.lastname,
        role: req.body.role
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
                        return res.status(500).send('DB: ERROR');
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


module.exports = router;