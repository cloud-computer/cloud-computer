# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
export DOCKER_HOST=localhost

# Create the CLOUD_COMPUTER_TERRAFORM volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_TERRAFORM_VOLUME:$CLOUD_COMPUTER_TERRAFORM \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_TERRAFORM

# Ensure the terraform backend storage bucket exists
yarn --cwd ../docker docker run \
  --entrypoint bash \
  --rm \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  -it \
  google/cloud-sdk:latest \
  -c "\
    gcloud auth activate-service-account --key-file $CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json; \
    gcloud config set project $(yarn --cwd ../credentials project); \
    gsutil mb gs://cloud-computer-$CLOUD_COMPUTER_HOST_USER 2>/dev/null || true; \
  "

# Sync with remote terraform state in cloud storage
yarn sync
