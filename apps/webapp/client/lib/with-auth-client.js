import React from 'react';
import logdown from './logger';

const log = logdown('auth-client');

export const withAuthClient = (BaseComponent) => ({...props}) => {

    const api = {
        get: async (url) => {
            try {
                log.info('GET', `${process.env.AUTH_SERVICE_HOST}${url}`);

                /**
                 * Fetch data
                 * @type {Response}
                 */
                const res = await fetch(`${process.env.AUTH_SERVICE_HOST}${url}`, {
                    method: 'GET',
                    headers: {}
                });

                /**
                 * Check if its ok else throw it
                  */
                if (res.ok) {
                    /** Serialize result **/
                    const result = await res.json();

                    log.info('RESULT',result);
                    return result;
                }

                log.error('ERROR',res);
                throw await res.json();
            } catch (e) {
                throw e;
            }
        },
        post: async (url, body) => {
            try {
                log.info(`POST ${process.env.AUTH_SERVICE_HOST}${url}`, body);
                /**
                 * Fetch data
                 * @type {Response}
                 */
                const res = await fetch(`${process.env.AUTH_SERVICE_HOST}${url}`, {
                    method: 'POST',
                    body : JSON.stringify(body),
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                });

                /**
                 * Check if its ok else throw it
                 */
                if (res.ok) {
                    /** Serialize result **/
                    const result = await res.json();

                    log.info('RESULT',result);
                    return result;
                }
                log.error('ERROR',res);
                throw await res.json();
            } catch (e) {
                throw e;
            }
        }
    };

    return <BaseComponent {...props} authAPI={api}/>
};