const {Client} = require('pg');

let client;

/** Get all credentials **/
const {
    env: {
        /** Postgres **/
        POSTGRES_USER,
        POSTGRES_HOST,
        POSTGRES_DB,
        POSTGRES_PASSWORD
    }
} = process;

module.exports = () => {
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
    client.connect((err) => {
        if (err) {
            console.error('connection error', err.stack);
        } else {
            console.log('connected');
        }
    });

    return client;
};