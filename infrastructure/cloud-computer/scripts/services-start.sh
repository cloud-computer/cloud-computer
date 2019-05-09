# Export cloud computer shell environment
eval "$(yarn environment)"

# Start the jest tests
yarn tmux:jest:start &

# Start the weechat client
yarn tmux:weechat:start &

# Start the xephyr server
yarn tmux:xephyr:start &

# Wait for services to start in parallel
wait

# Start the cloud computer terminal dashboard
yarn tmux:dashboard:start

# Start the cloud computer terminal web interface
yarn tmux:gotty:start
