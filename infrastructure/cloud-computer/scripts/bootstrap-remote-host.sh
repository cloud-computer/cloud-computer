# Point shell context to the current environment's terraform host
eval "$(yarn --cwd ../terraform environment)"

# Pull cloud computer container onto remote host
yarn --cwd ../containers pull:cloud-computer

# Bootstrap remote infrastructure tools
yarn bootstrap:infrastructure

# Start a terminal in the cloud computer
yarn --cwd ../docker-compose up:terminal

# Bootstrap the cloud computer repository
yarn exec:tty:terminal yarn bootstrap

# Populate the cloud computer docker image build cache in the background
yarn exec:tty:terminal yarn --cwd infrastructure/cloud-computer tmux new-session -d -s docker-build-cache-populate yarn --cwd ../containers sync:cloud-computer
