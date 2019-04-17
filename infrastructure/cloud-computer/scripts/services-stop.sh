# Export cloud computer shell environment
export $(yarn environment)

# Stop the cloud computer dashboard
yarn tmux:dashboard:stop

# Stop the cloud computer dashboard web interface
yarn tmux:dashboard:web:stop
