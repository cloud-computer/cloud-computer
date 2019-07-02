import {compose} from 'react-apollo';
import {Form, Icon, Input, Button, Row, Col, notification} from 'antd';

/** libs **/
import {withAuthClient} from '../lib/with-auth-client';

/** styles **/
const styles = {
    image : {
        width: '300px'
    },
    registerForm: {
        maxWidth: '300px',
        margin: '12% auto'
    },
    registerFormForgot: {
        float: 'right'
    },
    registerFormButton: {
        width: '100%'
    }
};

const Register = (props) => {
    const {getFieldDecorator} = props.form;

    const handleSubmit = e => {
        e.preventDefault();
        props.form.validateFields(async (err, {username, password, firstname, lastname}) => {
            if (!err) {
                try {
                    await props.authAPI.post('/auth/register', {
                        username,
                        password,
                        firstname,
                        lastname
                    });
                    window.location = '/login';
                } catch (e) {
                    if(e.message === 'duplicate key value violates unique constraint "user_username_key"') {
                        notification.error({
                            message: 'Oh no! Something went wrong',
                            description:
                                'Username has already been taken',
                        });
                    }
                }
            }
        });
    };
    return (
        <Row>
            <Col offset={8} span={8}>
                <Form onSubmit={handleSubmit} style={styles.registerForm}>
                    <img
                        style={styles.image}
                        src="https://avatars3.githubusercontent.com/u/49678748?s=400&amp;u=23aa86cbd4f8d9a5b2c2a8cc744c4d364903a772"
                        alt="Cloud Computer"/>
                    <h1>Register</h1>
                    <Form.Item>
                        {getFieldDecorator('username', {
                            rules: [{required: true, message: 'Please input your username!'}],
                        })(
                            <Input
                                prefix={<Icon type="user" style={{color: 'rgba(0,0,0,.25)'}}/>}
                                placeholder="Username"
                            />,
                        )}
                    </Form.Item>
                    <Form.Item>
                        {getFieldDecorator('password', {
                            rules: [{required: true, message: 'Please input your Password!'}],
                        })(
                            <Input
                                prefix={<Icon type="lock" style={{color: 'rgba(0,0,0,.25)'}}/>}
                                type="password"
                                placeholder="Password"
                            />,
                        )}
                    </Form.Item>
                    <Form.Item>
                        {getFieldDecorator('firstname', {
                            rules: [{required: true, message: 'Please input your first name!'}],
                        })(
                            <Input
                                prefix={<Icon type="user" style={{color: 'rgba(0,0,0,.25)'}}/>}
                                placeholder="First name"
                            />,
                        )}
                    </Form.Item>
                    <Form.Item>
                        {getFieldDecorator('lastname', {
                            rules: [{required: true, message: 'Please input your last name!'}],
                        })(
                            <Input
                                prefix={<Icon type="user" style={{color: 'rgba(0,0,0,.25)'}}/>}
                                placeholder="Last name"
                            />,
                        )}
                    </Form.Item>
                    <Form.Item>
                        <Button type="primary"
                                htmlType="submit"
                                style={styles.registerFormButton}>
                            Register
                        </Button>
                    </Form.Item>
                </Form>
            </Col>
        </Row>
    );
};


/** add HOC's need for the component **/
export default compose(
    Form.create({name: 'register'}),
    withAuthClient
)(Register);