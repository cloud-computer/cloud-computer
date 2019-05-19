# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
export DOCKER_HOST=localhost

yarn --cwd ../docker docker run \
  --env GOOGLE_APPLICATION_CREDENTIALS=$CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json \
  --env TF_CLI_ARGS_apply="-auto-approve -lock=false" \
  --env TF_CLI_ARGS_init="-backend-config bucket=$CLOUD_COMPUTER_HOST_DNS-cloud-computer -backend-config prefix=terraform -lock=false" \
  --env TF_CLI_ARGS_refresh="-lock=false" \
  --env TF_DATA_DIR=$CLOUD_COMPUTER_TERRAFORM \
  --env TF_IN_AUTOMATION=true \
  --env TF_VAR_CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT=$(yarn --cwd ../credentials project) \
  --env TF_VAR_CLOUD_COMPUTER_HOST_ID=$CLOUD_COMPUTER_HOST_ID \
  --env TF_VAR_CLOUD_COMPUTER_HOST_NAME=$CLOUD_COMPUTER_HOST_NAME \
  --env TF_VAR_CLOUD_COMPUTER_HOST_USER=$CLOUD_COMPUTER_HOST_USER \
  --env TF_VAR_CLOUD_COMPUTER_IMAGE=$CLOUD_COMPUTER_IMAGE \
  --env TF_VAR_CLOUD_COMPUTER_REPOSITORY=$CLOUD_COMPUTER_REPOSITORY \
  --env TF_VAR_CLOUD_COMPUTER_REPOSITORY_VOLUME=$CLOUD_COMPUTER_REPOSITORY_VOLUME \
  --rm \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --volume $CLOUD_COMPUTER_TERRAFORM_VOLUME:$CLOUD_COMPUTER_TERRAFORM \
  $CLOUD_COMPUTER_IMAGE \
  terraform "$@"
