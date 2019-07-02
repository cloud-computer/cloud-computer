import jwt_decode from 'jwt-decode';
import {compose, Subscription, withApollo} from 'react-apollo';
import {useEffect, useState} from 'react';
import {AUTH_TOKEN, HASURA_CLAIM, HASURA_USER_ID} from '../constants';
import {withProtectRoute} from '../lib/with-protect-route';
import gql from "graphql-tag";
import {withStreamClient} from "../lib/with-stream-client";
import {Button} from "antd";

const Stream = ({client, streamAPI}) => {
    const [provisioning, setProvisioning] = useState(false);
    const [build, setBuild] = useState(null);
    /**
     * 1. Check if there is an existing build
     * 2. If none then provision the box
     * 3. If existing just redirect to the new box but check the build if it is successful
     */
    useEffect(() => {
        const token = localStorage[AUTH_TOKEN];
        const userId = jwt_decode(token)[HASURA_CLAIM][HASURA_USER_ID];
        client.query({
            query: gql`
                query GetLatestBuild($id : Int){
                    build(where: {user_id: {_eq: $id}}, order_by: {id: desc}, limit: 1) {
                        id
                        code
                    }
                }

            `,
            variables: {
                id: userId
            }
        })
        .then(({data: {build}}) => {
            if (!build.length) {
                return streamAPI.get(`/provision?userId=${userId}`)
                    .then((data) => {
                        if(data.redirect) {
                            window.location = data.redirect;
                            return;
                        }
                        setBuild(data.build.id);
                        setProvisioning(true);
                    });
            }

            setBuild(build[0].id);
            setProvisioning(true);
        });
    }, []);

    if (provisioning) {
        return <Subscription
            variables={{
                id: build
            }}
            subscription={gql`
                    subscription getLogs($id : Int){
                      log(where: {build_id: {_eq: $id}}) {
                        log
                      }
                    }
                `}>
            {({data, loading}) => {
                if (loading || !data) {
                    return <div>
                        Fetching logs...
                    </div>
                }
                const logs = data.log.map(({log}, index) => {
                    return <p key={index} style={{'white-space': 'pre', paddingLeft: '10px'}}>{log}</p>
                });

                return <div>
                    <div style={{
                        margin: '30px'
                    }}>
                        <Subscription
                                    variables={{
                                        id: build
                                    }}
                                    subscription={gql`
                                        subscription getBuild($id : Int){
                                              build(where:{
                                                id :{
                                                  _eq :$id
                                                }
                                              }) {
                                                code
                                              }
                                         }
                                    `}>
                                    {({data, loading}) => {
                                        if(data) {
                                            const buildCode = data.build[0].code;
                                            if(+buildCode == 0) {
                                                return <Button onClick={()=> window.location = 'https://gideon.cloudcomputer.dev' }type="primary">Go to cloud computer</Button>
                                            }
                                        }
                                        return <div></div>
                                    }}
                        </Subscription>
                    </div>
                    <div style={{
                        overflow: 'hidden',
                        margin: '30px',
                        background: '#2b2b2b',
                        paddingTop: '20px',
                        paddingBottom : '20px',
                        color: '#f1f1f1'
                    }}>
                        {logs}
                    </div>
                </div>
            }}
        </Subscription>
    }

    return (
        <div>
            Fetching Status...
        </div>
    )
};

/** add HOC's need for the component **/
export default compose(
    withProtectRoute,
    withApollo,
    withStreamClient
)(Stream);