import {compose} from 'react-apollo';
import {withProtectRoute} from '../lib/with-protect-route';

const Index = () => {
    return (
        <div>
            Hello you are logged in
        </div>
    )
};

/** add HOC's need for the component **/
export default compose(
    withProtectRoute
)(Index);