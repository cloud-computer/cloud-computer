import React from 'react';

export const withAuthClient = (BaseComponent) => ({...props}) => {
    return <BaseComponent {...props} />
};