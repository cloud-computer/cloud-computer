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

# Ensure the terraform backend storage bucket exists
yarn --cwd ../docker docker run \
  --env GOOGLE_APPLICATION_CREDENTIALS=$CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json \
  --rm \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  google/cloud-sdk:latest \
  gsutil mb gs://terraform

# Sync with remote terraform state in cloud storage
yarn sync
