# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
export DOCKER_HOST=localhost

# Create the CLOUD_COMPUTER_CREDENTIALS volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_CREDENTIALS:$CLOUD_COMPUTER_CREDENTIALS \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_CREDENTIALS

# Extract credentials from the environment to local disk if present
if [ ! -z "$CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS" ]; then
  printf %s "$CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS" > $PWD/cloud-provider.json
fi

# Copy cloud provider credentials to the CLOUD_COMPUTER_CREDENTIALS volume
cat $PWD/cloud-provider.json | \
  yarn --cwd ../docker docker run \
    --rm \
    --interactive \
    --volume CLOUD_COMPUTER_CREDENTIALS:$CLOUD_COMPUTER_CREDENTIALS \
    $CLOUD_COMPUTER_IMAGE \
    zsh -c "cat > $CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json"

# Exclude user credentials from being committed
yarn --cwd ../git ignore-changes ../../infrastructure/credentials/cloud-provider.json
