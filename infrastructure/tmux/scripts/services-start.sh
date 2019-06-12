# Start the jest tests
yarn jest:start &

# Start the weechat client
yarn weechat:start &

# Wait for services to start in parallel
wait

# Start the cloud computer terminal dashboard
yarn dashboard:start

# Start the cloud computer terminal web interface
yarn gotty:start
