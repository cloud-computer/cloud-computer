# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Create the CLOUD_COMPUTER_CREDENTIALS volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  cloud-computer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_CREDENTIALS

# Exclude user credentials from being committed
git update-index --assume-unchanged weechat.env
