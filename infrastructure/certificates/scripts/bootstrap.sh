# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create the CLOUD_COMPUTER_CERTIFICATES volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_CERTIFICATES_VOLUME:$CLOUD_COMPUTER_CERTIFICATES \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_CERTIFICATES
