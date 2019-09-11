import * as bodyParser from 'body-parser';
import * as cors from 'cors';
import * as express from 'express';
import * as passport from 'passport';

import { initPassport } from './passport';
import { router } from './routes';

initPassport();

const app = express();

app.use(bodyParser.json());
app.use(cors());
app.use(passport.initialize());
app.use('/auth', router);
app.listen(3000);
