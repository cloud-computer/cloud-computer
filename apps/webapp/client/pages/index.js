import {Fragment} from 'react';
import {compose} from 'react-apollo';
import Router from 'next/router';
import {withProtectRoute} from '../lib/with-protect-route';
import {Col, Row} from "antd";

/** styles **/
const styles = {
    container : {
        paddingTop: '15%'
    },
    title : {
      textAlign : 'center'
    },
    image : {
        width: '150px'
    },
    googleImage : {
        width: '300px'
    },
    cloudImageContainer : {
        textAlign : 'right',
        paddingRight: '50px'
    },
    gcpImageContainer : {
        paddingTop : '40px',
        paddingLeft: '10px'
    }
};

const Index = () => {
    return (
            <Row style={styles.container}>
                <Col xs={24} style={styles.title}>
                    <h1>CHOOSE PROVIDER</h1>
                </Col>
                <Col xs={12} style={styles.cloudImageContainer}>
                    <img
                        style={styles.image}
                        src="https://avatars3.githubusercontent.com/u/49678748?s=400&amp;u=23aa86cbd4f8d9a5b2c2a8cc744c4d364903a772"
                        alt="Cloud Computer"
                        onClick={()=>{
                            Router.push('/stream')
                        }}
                    />
                </Col>
                <Col xs={12} style={styles.gcpImageContainer}>
                    <img  style={styles.googleImage}
                          src="https://cloud.google.com/_static/2f77eb3e34/images/cloud/cloud-logo.svg"
                          alt="Google Cloud"
                          onClick={()=>{
                              Router.push('/stream')
                          }}
                    />
                </Col>
            </Row>
    )
};

/** add HOC's need for the component **/
export default compose(
    withProtectRoute
)(Index);