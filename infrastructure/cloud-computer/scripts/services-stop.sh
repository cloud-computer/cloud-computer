# Export cloud computer shell environment
eval "$(yarn environment)"

# Stop the cloud computer dashboard
yarn tmux:dashboard:stop

# Stop the cloud computer dashboard web interface
yarn tmux:dashboard:web:stop
