# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Generate an rsa keypair for accessing the cloud computer host vm
yarn --cwd ../docker docker run \
  --detach \
  --name $CREDENTIALS_CONTAINER \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --volume $CLOUD_COMPUTER_DOCKER_VOLUME:$CLOUD_COMPUTER_DOCKER \
  cloud-computer/cloud-computer:latest \
  sleep infinity
