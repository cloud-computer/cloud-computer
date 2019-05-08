# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Extract credentials from the environment or repository
CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS=${CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS-$(cat $PWD/cloud-provider.json)}

# Create the CLOUD_COMPUTER_CREDENTIALS volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_CREDENTIALS

# Copy cloud provider credentials to the CLOUD_COMPUTER_CREDENTIALS volume
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  zsh -c "printf %s \"$CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS\" > $CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json"

# Exclude user credentials from being committed
yarn --cwd ../git ignore-changes ../../infrastructure/credentials/cloud-provider.json
