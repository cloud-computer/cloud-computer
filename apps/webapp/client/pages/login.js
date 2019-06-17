import {compose} from 'react-apollo';
import {Form, Icon, Input, Button, Checkbox, Row, Col} from 'antd';

/** libs **/
import {withAuthClient} from '../lib/with-auth-client';

/** styles **/
const styles = {
    loginForm: {
        maxWidth: '300px',
        margin: '45% auto'
    },
    loginFormForgot: {
        float: 'right'
    },
    loginFormButton: {
        width: '100%'
    },
    loginGoogle: {
        width: '100%'
    }
};


const Login = (props) => {
    const {getFieldDecorator} = props.form;

    const handleSubmit = e => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
                console.log('Received values of form: ', values);
            }
        });
    };
    return (
        <Row>
            <Col offset={8} span={8}>
                <Form onSubmit={handleSubmit} style={styles.loginForm}>
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
                        {getFieldDecorator('remember', {
                            valuePropName: 'checked',
                            initialValue: true,
                        })(<Checkbox>Remember me</Checkbox>)}
                        <a style={styles.loginFormForgot} href="">
                            Forgot password
                        </a>
                        <Button type="primary" htmlType="submit" style={styles.loginFormButton}>
                            Log in
                        </Button>
                        <Button icon="google" style={styles.loginGoogle} onClick={()=>window.open(process.env.GOOGLE_REDIRECT)}>
                            Sign-In with Google
                        </Button>
                        {/*<Button icon="facebook" style={styles.loginGoogle} onClick={()=>window.open('http://localhost:9995/facebook')}>*/}
                            {/*Sign-In with Facebook*/}
                        {/*</Button>*/}
                        Or <a href="">register now!</a>
                    </Form.Item>
                </Form>
            </Col>
        </Row>
    );
};


/** add HOC's need for the component **/
export default compose(
    Form.create({name: 'login'}),
    withAuthClient
)(Login);