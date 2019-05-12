# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
export DOCKER_HOST=localhost

# Create the CLOUD_COMPUTER_TERRAFORM volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_TERRAFORM_VOLUME:$CLOUD_COMPUTER_TERRAFORM \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_TERRAFORM

# If we are on a cloud computer, skip creation of cloud computer state bucket
if [ -z "$CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS" ]; then

  # Ensure the terraform backend storage bucket exists
  yarn --cwd ../docker docker run \
    --entrypoint bash \
    --rm \
    --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
    google/cloud-sdk:latest \
    -c "\
      gcloud auth activate-service-account --key-file $CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json; \
      gcloud config set project $(yarn --cwd ../credentials project); \
      gsutil mb gs://$CLOUD_COMPUTER_HOST_DNS 2>/dev/null || true; \
    "

fi

# Sync with remote terraform state in cloud storage
yarn sync
