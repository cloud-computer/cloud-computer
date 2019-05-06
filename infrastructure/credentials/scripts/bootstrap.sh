# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

CREDENTIALS_IMPORT_CONTAINER="${COMPOSE_PROJECT_NAME}_cloud-computer-credentials-import-$(date +%M%S)"

# Create the CLOUD_COMPUTER_CREDENTIALS volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  $CLOUD_COMPUTER_REPOSITORY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_CREDENTIALS

# Create a container for accessing the CLOUD_COMPUTER_CREDENTIALS volume
yarn --cwd ../docker docker run \
  --detach \
  --name $CREDENTIALS_IMPORT_CONTAINER \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --volume $CLOUD_COMPUTER_DOCKER_VOLUME:$CLOUD_COMPUTER_DOCKER \
  $CLOUD_COMPUTER_REPOSITORY/$CLOUD_COMPUTER_IMAGE:latest \
  sleep infinity

# Copy cloud provider credentials from the repository to the CLOUD_COMPUTER_CREDENTIALS volume
cat $PWD/cloud-provider.json | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_IMPORT_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json"

# Remove the temporary container
yarn --cwd ../docker docker rm \
  --force \
  $CREDENTIALS_IMPORT_CONTAINER

# Exclude user credentials from being committed
yarn --cwd ../git ignore-changes ../../infrastructure/credentials/cloud-provider.json
