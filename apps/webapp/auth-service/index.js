const express = require('express');
const cors = require('cors');
const passport = require('passport');
const bodyParser = require('body-parser');

/**
 * Express routes
 */
const authRouter = require('./routes/auth');

/**
 * Init scripts
 */
const passportInit = require('./init/passport');

/**
 * Initialize express
 */
const app = express();

/**
 * Middlewares
 */
app.use(bodyParser.json());
app.use(cors());

/**
 * Initialize passport
 */
app.use(passport.initialize());
passportInit();

/**
 * Attah routes to application
 */
app.use('/auth', authRouter);

/** Listen to default 3000 **/
app.listen(3000);