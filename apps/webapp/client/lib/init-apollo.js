import {ApolloClient, InMemoryCache, HttpLink} from 'apollo-boost';
import fetch from 'isomorphic-unfetch';
import {split} from 'apollo-link';
import {onError} from 'apollo-link-error';
import {WebSocketLink} from 'apollo-link-ws';
import {getMainDefinition} from 'apollo-utilities';
import {setContext} from 'apollo-link-context';
import Router from 'next/dist/client/router';

let apolloClient = null;

// Polyfill fetch() on the server (used by apollo-client)
if (!process.browser) {
    global.fetch = fetch;
}

function create(initialState) {
    const wsLink = process.browser
        ? new WebSocketLink({
            uri: `${process.env.REACT_APP_WEBSOCKET_HOST}`,
            options: {
                reconnect: true,
                connectionParams: {
                    headers: {
                        Authorization: `Bearer ${localStorage.getItem(process.env.TOKEN)}`
                    }
                }
            }
        })
        : null;

    const httpLink = new HttpLink({
        uri: `${process.env.REACT_APP_HOST}`
    });

    const errorLink = onError(({graphQLErrors, networkError}) => {
        if (graphQLErrors) {
            let noAuthentication = false;
            graphQLErrors.map(({message, locations, path}) => {
                if ('Missing Authorization header in JWT authentication mode' === message) {
                    noAuthentication = true;
                }
                console.log(`[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`);
            });
            if (noAuthentication) {
                return Router.push(`/login`);
            }
        }

        if (networkError) console.log(`[Network error]: ${networkError}`);
    });

    const authLink = setContext((_, {headers}) => {
        const token = localStorage.getItem(process.env.TOKEN);
        let baseHeaders = {
            ...headers
        };

        // Check if there is a token
        if (token) {
            baseHeaders.authorization = `Bearer ${token}`;
        }
        return {headers: baseHeaders};
    });

    const link = process.browser
        ? split(
            // split based on operation type
            ({query}) => {
                const {kind, operation} = getMainDefinition(query);
                return kind === 'OperationDefinition' && operation === 'subscription';
            },
            wsLink,
            httpLink
        )
        : httpLink;

    return new ApolloClient({
        connectToDevTools: process.browser,
        ssrMode: !process.browser, // Disables forceFetch on the server (so queries are only run once)
        link: authLink.concat(errorLink.concat(link)),
        cache: new InMemoryCache().restore(initialState || {})
    });
}

export default function initApollo(initialState) {
    // Make sure to create a new client for every server-side request so that data
    // isn't shared between connections (which would be bad)
    if (!process.browser) {
        return create(initialState);
    }

    // Reuse client on the client-side
    if (!apolloClient) {
        apolloClient = create(initialState);
    }

    return apolloClient;
}
