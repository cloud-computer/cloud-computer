# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
export DOCKER_HOST=localhost

yarn --cwd ../docker docker run \
  --env GOOGLE_APPLICATION_CREDENTIALS=$CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json \
  --env TF_DATA_DIR=$CLOUD_COMPUTER_TERRAFORM \
  --env TF_IN_AUTOMATION=true \
  --rm \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --volume $CLOUD_COMPUTER_TERRAFORM_VOLUME:$CLOUD_COMPUTER_TERRAFORM \
  --workdir $(yarn workdir) \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  terraform output "$@"
