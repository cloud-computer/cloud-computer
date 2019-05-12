# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
export DOCKER_HOST=localhost

yarn --cwd ../docker docker run \
  --env HOME=$CLOUD_COMPUTER_REPOSITORY \
  --env CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT=$(yarn --cwd ../credentials project) \
  --env CLOUD_COMPUTER_CREDENTIALS \
  --rm \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --workdir $CLOUD_COMPUTER_REPOSITORY/infrastructure/packer \
  $CLOUD_COMPUTER_IMAGE \
  packer "$@"
