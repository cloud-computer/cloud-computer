const passport = require('passport');
const {Strategy: GoogleStrategy} = require('passport-google-oauth20');
const {Strategy: GitHubStrategy} = require('passport-github');

/** Get all credentials **/
const {
    env: {
        /** Google **/
        GOOGLE_CLIENT_ID,
        GOOGLE_CLIENT_SECRET,
        GOOGLE_CALLBACK,

        /** Github **/
        GITHUB_CLIENT_ID,
        GITHUB_CLIENT_SECRET,
        GITHUB_CALLBACK
    }
} = process;

module.exports = () => {
    /** Serializers for passport **/
    passport.serializeUser((user, cb) => cb(null, user));
    passport.deserializeUser((obj, cb) => cb(null, obj));

    /** Common callback **/
    const callback = (accessToken, refreshToken, profile, cb) => {
        cb(null, profile)
    };
    console.log(process.env)
    /** Add google auth **/
    passport.use(new GoogleStrategy({
        clientID: GOOGLE_CLIENT_ID,
        clientSecret: GOOGLE_CLIENT_SECRET,
        callbackURL: GOOGLE_CALLBACK
    }, callback));

    /** Add github auth **/
    passport.use(new GitHubStrategy({
        clientID: GITHUB_CLIENT_ID,
        clientSecret: GITHUB_CLIENT_SECRET,
        callbackURL: GITHUB_CALLBACK
    }, callback));
};
