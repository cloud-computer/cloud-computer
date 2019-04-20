# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

yarn --cwd ../docker docker run \
  --env CLOUDSDK_CONFIG=$CLOUD_COMPUTER_GCLOUD \
  --env DOCKER_CONFIG=$CLOUD_COMPUTER_DOCKER \
  --interactive \
  --rm \
  --tty \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --volume $CLOUD_COMPUTER_DOCKER_VOLUME:$CLOUD_COMPUTER_DOCKER \
  --volume $CLOUD_COMPUTER_GCLOUD_VOLUME:$CLOUD_COMPUTER_GCLOUD \
  --workdir $CLOUD_COMPUTER_BACKEND \
  cloud-computer/cloud-computer:latest \
  gcloud --quiet "$@"
