# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Point shell context to the local docker host
export $(DOCKER_HOST=localhost yarn --cwd ../docker environment)

yarn --cwd ../docker docker run \
  --env CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT=$CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT \
  --env COMPOSE_PROJECT_NAME \
  --env HOME=$CLOUD_COMPUTER_BACKEND \
  --rm \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --workdir $CLOUD_COMPUTER_BACKEND/infrastructure/packer/$TERRAFORM_TARGET \
  cloud-computer/cloud-computer:latest \
  packer "$@"
