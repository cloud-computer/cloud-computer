import App, {Container} from 'next/app';
import React from 'react';
import {ApolloProvider} from 'react-apollo';

/** Include antd css **/
import 'antd/dist/antd.min.css';

/** Get apollo client **/
import withApolloClient from '../lib/with-apollo-client';

class MyApp extends App {
    render() {
        const {Component, pageProps, apolloClient} = this.props;
        return (
            <Container>
                <ApolloProvider client={apolloClient}>
                    <Component {...pageProps} />
                </ApolloProvider>
            </Container>
        );
    }
}

export default withApolloClient(MyApp);