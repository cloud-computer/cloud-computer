# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

CREDENTIALS_CONTAINER="${COMPOSE_PROJECT_NAME}_cloud-computer-credentials-$(date +%M%S)"

# Create a container for accessing the CLOUD_COMPUTER_CREDENTIALS volume
yarn --cwd ../docker docker run \
  --detach \
  --name $CREDENTIALS_CONTAINER \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --volume $CLOUD_COMPUTER_DOCKER_VOLUME:$CLOUD_COMPUTER_DOCKER \
  cloudnativecomputer/cloud-computer:latest \
  sleep infinity

# Copy cloud provider credentials from the repository to the CLOUD_COMPUTER_CREDENTIALS volume
cat $PWD/cloud-provider.json | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json"

# Remove the temporary container
yarn --cwd ../docker docker rm \
  --force \
  $CREDENTIALS_CONTAINER
