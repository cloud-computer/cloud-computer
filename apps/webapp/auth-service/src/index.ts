import * as bodyParser from 'body-parser';
import * as cors from 'cors';
import * as express from 'express';
import * as passport from 'passport';

import { init as initPassport } from './init/passport';
import { router as authRouter } from './routes/auth';

initPassport();

const app = express();

app.use(bodyParser.json());
app.use(cors());
app.use(passport.initialize());
app.use('/auth', authRouter);
app.listen(3000);
