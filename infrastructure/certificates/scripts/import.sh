# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

CERTIFICATES_CONTAINER="${COMPOSE_PROJECT_NAME}_cloud-computer-certificates-$(date +%M%S)"

# Create a container for accessing the CLOUD_COMPUTER_CERTIFICATES volume
yarn --cwd ../docker docker run \
  --detach \
  --name $CERTIFICATES_CONTAINER \
  --volume $CLOUD_COMPUTER_CERTIFICATES_VOLUME:$CLOUD_COMPUTER_CERTIFICATES \
  cloud-computer/cloud-computer:latest \
  sleep infinity

# Copy cloudflare tls root certificate from the repository to the CLOUD_COMPUTER_CERTIFICATES volume
cat $PWD/ca.pem | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CERTIFICATES_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CERTIFICATES/ca.pem" &

# Copy cloud computer tls certificate from the repository to the CLOUD_COMPUTER_CERTIFICATES volume
cat $PWD/cert.pem | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CERTIFICATES_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CERTIFICATES/cert.pem" &

# Copy cloud computer tls private key from the repository to the CLOUD_COMPUTER_CERTIFICATES volume
cat $PWD/key.pem | \
  yarn --cwd ../docker docker exec \
  --interactive \
  $CERTIFICATES_CONTAINER \
  zsh -c "cat > $CLOUD_COMPUTER_CERTIFICATES/key.pem" &

# Wait for copies to complete in parallel
wait

# Remove the temporary container
yarn --cwd ../docker docker rm \
  --force \
  $CERTIFICATES_CONTAINER
