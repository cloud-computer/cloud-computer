const path = require('path');
require('dotenv').config({
    path: path.resolve(process.cwd(), '../.env')
});
const webpack = require('webpack');
const withCSS = require('@zeit/next-css');

module.exports = withCSS({
    webpack: (config) => {
        config.plugins.push(new webpack.EnvironmentPlugin(process.env));
        return config;
    }
});
