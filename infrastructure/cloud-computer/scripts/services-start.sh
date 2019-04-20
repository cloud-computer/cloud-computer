# Export cloud computer shell environment
eval "$(yarn environment)"

# Start the jest tests
yarn tmux:jest:start &

# Start the majjestic interface
yarn tmux:majestic:start &

# Start the frontend build
yarn tmux:frontend:build:start &

# Start the weechat client
yarn tmux:weechat:start &

# Start the xephyr server
yarn tmux:xephyr:start &

# Wait for services to start in parallel
wait

# Start the cloud computer dashboard
yarn tmux:dashboard:start

# Start the cloud computer dashboard web interface
yarn tmux:dashboard:web:start
