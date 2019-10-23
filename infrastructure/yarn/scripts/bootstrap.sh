# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create the CLOUD_COMPUTER_YARN volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_YARN:$CLOUD_COMPUTER_YARN \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_YARN
