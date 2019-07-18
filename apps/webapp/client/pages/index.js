import {compose, withApollo} from 'react-apollo';
import Router from 'next/router';
import jwt_decode from 'jwt-decode';
import {Col, Input, Modal, notification, Row} from 'antd';
import {useState} from 'react';
import gql from 'graphql-tag';
import {AUTH_TOKEN, HASURA_CLAIM, HASURA_USER_ID} from '../constants';
import {withProtectRoute} from '../lib/with-protect-route';

/** styles **/
const styles = {
    container: {
        paddingTop: '15%'
    },
    title: {
        textAlign: 'center'
    },
    image: {
        width: '150px'
    },
    googleImage: {
        width: '300px'
    },
    cloudImageContainer: {
        textAlign: 'right',
        paddingRight: '50px'
    },
    gcpImageContainer: {
        paddingTop: '40px',
        paddingLeft: '10px'
    }
};

const Index = ({client}) => {
    const [visible, setVisible] = useState(false);
    const [cloudUser, setCloudUser] = useState(null);

    const handleOk = async () => {
        try {
            const token = localStorage[AUTH_TOKEN];
            const userId = jwt_decode(token)[HASURA_CLAIM][HASURA_USER_ID];

            const {data: {user}} = await client.query({
                query: gql`
                    query CheckIfExist($cloudUser : String){
                        user(where:{
                            cloud_user : {
                                _eq :$cloudUser
                            }
                        }){
                            id
                            cloud_url
                            cloud_user
                        }
                    }
                `,
                variables: {
                    cloudUser: cloudUser
                }
            });

            if (user.length) {
                return notification.error({
                    message: 'Something went wrong',
                    description: 'You cant use this cloud computer name its existing already',
                });
            }

            await client.mutate({
                mutation: gql`
                    mutation UpdateCloudUrl($userId: bigint,  $cloudUrl : String, $cloudUser : String) {
                        update_user(where:{
                            id: {
                                _eq : $userId
                            }
                        }, _set :{
                            cloud_url : $cloudUrl,
                            cloud_user : $cloudUser
                        }) {
                            returning {
                                id
                            }
                        }
                    }
                `,
                variables: {
                    cloudUrl: `https://${cloudUser}.cloud-computer.dev`,
                    cloudUser,
                    userId
                }
            });

            notification.success({
                message: 'Nice! its available',
                description: 'Time to build your server. Be patient :). Let me just redirect you',
            });

            setTimeout(() => {
                Router.push({
                    pathname: '/stream',
                    query: {
                        cloudUser
                    }
                })
            }, 500);

        } catch (e) {
            notification.error({
                message: 'Something went wrong',
                description: 'I cant seem to process this request',
            });
        }
    };
    const handleCancel = () => {
        setVisible(false);
    };

    return (
        <Row style={styles.container}>
            <Modal
                title="Cloud computer"
                visible={visible}
                onOk={handleOk}
                onCancel={handleCancel}
            >
                <p>Please enter the name of you cloud computer:</p>
                <p><Input placeholder="jacksonwizard" value={cloudUser}
                          onChange={(cloudUser) => setCloudUser(cloudUser.currentTarget.value)}/></p>
            </Modal>

            <Col xs={24} style={styles.title}>
                <h1>CHOOSE PROVIDER</h1>
            </Col>
            <Col xs={12} style={styles.cloudImageContainer}>
                <img
                    style={styles.image}
                    src="https://avatars3.githubusercontent.com/u/49678748?s=400&amp;u=23aa86cbd4f8d9a5b2c2a8cc744c4d364903a772"
                    alt="Cloud Computer"
                    onClick={() => setVisible(true)}
                />
            </Col>
            <Col xs={12} style={styles.gcpImageContainer}>
                <img style={styles.googleImage}
                     src="https://cloud.google.com/_static/2f77eb3e34/images/cloud/cloud-logo.svg"
                     alt="Google Cloud"
                     onClick={() => {
                         Router.push('/stream')
                     }}
                />
            </Col>
        </Row>
    )
};

/** add HOC's need for the component **/
export default compose(
    withProtectRoute,
    withApollo
)(Index);
