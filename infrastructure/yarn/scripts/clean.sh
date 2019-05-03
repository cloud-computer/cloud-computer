# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
eval "$(DOCKER_HOST=localhost yarn --cwd ../docker environment)"

# Remove all files in the CLOUD_COMPUTER_YARN volume
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_YARN_VOLUME:$CLOUD_COMPUTER_YARN \
  cloudnativecomputer/cloud-computer:latest \
  zsh -c "rm -rf $CLOUD_COMPUTER_YARN/*"
