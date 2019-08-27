# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create the CLOUD_COMPUTER_CLOUDSTORAGE volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_CLOUDSTORAGE_VOLUME:$CLOUD_COMPUTER_CLOUDSTORAGE \
  $CLOUD_COMPUTER_IMAGE \
  chown cloud:cloud $CLOUD_COMPUTER_CLOUDSTORAGE

# Copy cloud provider credentials to the CLOUD_COMPUTER_CLOUDSTORAGE volume
yarn --cwd ../docker docker run \
  --rm \
  --interactive \
  --volume $CLOUD_COMPUTER_CLOUDSTORAGE_VOLUME:$CLOUD_COMPUTER_CLOUDSTORAGE \
  $CLOUD_COMPUTER_IMAGE \
  zsh -c "mkdir $CLOUD_COMPUTER_CLOUDSTORAGE/cloud-storage"
