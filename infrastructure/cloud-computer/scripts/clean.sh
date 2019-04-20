# Export cloud computer shell environment
eval "$(yarn environment)"

# Point shell context to the local docker host
eval "$(DOCKER_HOST=localhost yarn --cwd ../docker environment)"

# Remove all files in the CLOUD_COMPUTER_HOME volume
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_HOME_VOLUME:$CLOUD_COMPUTER_HOME \
  cloud-computer/cloud-computer:latest \
  zsh -c "rm -rf $CLOUD_COMPUTER_HOME/*"
