# Export cloud computer shell environment
eval $(yarn --cwd ../cloud-computer environment)

DOCKER_CERTIFICATES_IMPORT_CONTAINER="${COMPOSE_PROJECT_NAME}_cloud-computer-docker-certificates-import-$(date +%M%S)"

# Create the CLOUD_COMPUTER_DOCKER volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_DOCKER_VOLUME:$CLOUD_COMPUTER_DOCKER \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_DOCKER

# Create a container for accessing the CLOUD_COMPUTER_DOCKER volume
yarn --cwd ../docker docker run \
  --detach \
  --name $DOCKER_CERTIFICATES_IMPORT_CONTAINER \
  --volume $CLOUD_COMPUTER_DOCKER_VOLUME:$CLOUD_COMPUTER_DOCKER \
  cloudnativecomputer/cloud-computer:latest \
  zsh -c "mkdir $CLOUD_COMPUTER_DOCKER/.docker; sleep infinity"

# Copy cloud computer tls certificate from the repository to the CLOUD_COMPUTER_DOCKER volume
cat $PWD/cert.pem | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $DOCKER_CERTIFICATES_IMPORT_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_DOCKER/cert.pem" &

# Copy cloud computer tls private key from the repository to the CLOUD_COMPUTER_DOCKER volume
cat $PWD/key.pem | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $DOCKER_CERTIFICATES_IMPORT_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_DOCKER/key.pem" &

# Wait for copies to complete in parallel
wait

# Remove the temporary container
yarn --cwd ../docker docker rm \
  --force \
  $DOCKER_CERTIFICATES_IMPORT_CONTAINER
