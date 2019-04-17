# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

CREDENTIALS_CONTAINER="${COMPOSE_PROJECT_NAME}_cloud-computer-credentials-$(date +%M%S)"

# Create a container for accessing the CLOUD_COMPUTER_CREDENTIALS volume
yarn --cwd ../docker docker run \
  --detach \
  --name $CREDENTIALS_CONTAINER \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --volume $CLOUD_COMPUTER_DOCKER_VOLUME:$CLOUD_COMPUTER_DOCKER \
  cloud-computer/cloud-computer:latest \
  sleep infinity

# Copy google credentials from the repository to the CLOUD_COMPUTER_CREDENTIALS volume
cat $PWD/cloud-computer.json | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CREDENTIALS/cloud-computer.json" &

# Copy private key from the repository to the CLOUD_COMPUTER_CREDENTIALS volume
cat $PWD/cloud-computer.prv | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CREDENTIALS/cloud-computer.prv" &

# Copy private key from the repository to the CLOUD_COMPUTER_CREDENTIALS volume
cat $PWD/cloud-computer.pub | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CREDENTIALS/cloud-computer.pub" &

# Copy weechat user credentials from the repository to the CLOUD_COMPUTER_CREDENTIALS volume
cat $PWD/weechat.env | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CREDENTIALS/weechat.env" &

# Copy docker registry credentials from the repository to the CLOUD_COMPUTER_DOCKER volume
cat $PWD/docker.json | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_DOCKER/config.json" &

# Wait for copies to complete in parallel
wait

# Restrict private key permissions
yarn --cwd ../docker docker exec \
  --interactive \
  $CREDENTIALS_CONTAINER \
  chmod 600 $CLOUD_COMPUTER_CREDENTIALS/cloud-computer.prv

# Remove the temporary container
yarn --cwd ../docker docker rm \
  --force \
  $CREDENTIALS_CONTAINER
