# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
export DOCKER_HOST=localhost

# Create the CLOUD_COMPUTER_TERRAFORM volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_TERRAFORM_VOLUME:$CLOUD_COMPUTER_TERRAFORM \
  cloud-computer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_TERRAFORM

# Import credentials so terraform can access google cloud api
yarn --cwd ../credentials run import

# Sync with remote terraform state in cloud storage
yarn sync
