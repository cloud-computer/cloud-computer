# Point shell context to the current environment's terraform host
eval "$(yarn --cwd ../terraform environment)"

# Ensure the latest cloud computer container is available
yarn --cwd ../containers pull:cloud-computer

# Restart all cloud computer containers
yarn --cwd ../docker-compose restart

# Start the cloud computer services
yarn exec:tty:terminal yarn --cwd infrastructure/cloud-computer yarn services:start
