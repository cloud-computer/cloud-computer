# Point shell context to the current environment's terraform host
export $(yarn --cwd ../terraform environment)

# Pull cloud computer container onto remote host
yarn --cwd ../containers pull:cloud-computer

# Bootstrap remote infrastructure tools
yarn bootstrap:infrastructure

# Start a terminal in the cloud computer
yarn --cwd ../docker-compose apply:terminal

# Bootstrap the cloud computer codebase
yarn exec:tty:terminal yarn bootstrap

# Start a cloud computer container build to populate the docker image cache
yarn exec:tty:terminal yarn --cwd infrastructure/cloud-computer tmux new-session -d -s docker-cache-populate yarn --cwd ../containers sync:cloud-computer
