# Ensure the latest cloud computer container is available
yarn --cwd ../containers pull:cloud-computer

# Restart all cloud computer containers
yarn --cwd ../docker-compose restart

# Start the cloud computer services
yarn exec:terminal yarn --cwd infrastructure/tmux yarn services:start
