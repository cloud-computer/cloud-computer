# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create the CLOUD_COMPUTER_GCLOUD volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_GCLOUD_VOLUME:$CLOUD_COMPUTER_GCLOUD \
  cloud-computer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_GCLOUD
