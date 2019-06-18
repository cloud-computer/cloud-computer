import {withRouter} from 'next/router';
import {AUTH_TOKEN} from '../constants';

export const withProtectRoute = (BaseComponent) => withRouter(({...props}) => {
    if(process.browser && props.router.query && props.router.query.token ) {
        localStorage.setItem(AUTH_TOKEN,props.router.query.token);
    }

    if(process.browser && !localStorage.getItem(AUTH_TOKEN)) {
        return window.location = '/login';
    }

    /** This is for handling the index page cause its being used
     * for handling the token
     */
    let token;
    if(process.browser) {
        token = localStorage.getItem(AUTH_TOKEN);
    }

    if(!token) {
        return (
            <div>
                Loading...
            </div>
        )
    }

    return <BaseComponent {...props}/>
});