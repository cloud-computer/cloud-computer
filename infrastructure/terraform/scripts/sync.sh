# Point shell context to the current environment's terraform host
eval "$(yarn environment)"

# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
eval "$(DOCKER_HOST=localhost yarn --cwd ../docker environment)"

# Reinitialize backend
yarn terraform init

# Sync with remote terraform state in cloud storage
yarn refresh
