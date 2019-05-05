# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Remove the CLOUD_COMPUTER_DOCKER_VOLUME volume
yarn --cwd ../docker docker volume rm $CLOUD_COMPUTER_DOCKER_VOLUME
