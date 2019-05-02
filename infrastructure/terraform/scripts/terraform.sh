# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
eval "$(DOCKER_HOST=localhost yarn --cwd ../docker environment)"

yarn --cwd ../docker docker run \
  --env GOOGLE_APPLICATION_CREDENTIALS=$CLOUD_COMPUTER_CREDENTIALS/cloud-provider.json \
  --env TF_CLI_ARGS_apply="-auto-approve -lock=false" \
  --env TF_CLI_ARGS_destroy="-auto-approve -lock=false" \
  --env TF_CLI_ARGS_init="-backend-config bucket=cloud-computer-$CLOUD_COMPUTER_HOST_USER -backend-config prefix=terraform -lock=false" \
  --env TF_CLI_ARGS_refresh="-lock=false" \
  --env TF_CLI_ARGS_taint="-lock=false" \
  --env TF_DATA_DIR=$CLOUD_COMPUTER_TERRAFORM \
  --env TF_IN_AUTOMATION=true \
  --env TF_VAR_CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT=$(yarn --cwd ../credentials project) \
  --env TF_VAR_CLOUD_COMPUTER_HOST_ID=$CLOUD_COMPUTER_HOST_ID \
  --env TF_VAR_CLOUD_COMPUTER_HOST_NAME=$CLOUD_COMPUTER_HOST_NAME \
  --env TF_VAR_CLOUD_COMPUTER_HOST_USER=$CLOUD_COMPUTER_HOST_USER \
  --rm \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --volume $CLOUD_COMPUTER_CERTIFICATES_VOLUME:$CLOUD_COMPUTER_CERTIFICATES \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  --volume $CLOUD_COMPUTER_KUBECONFIGS_VOLUME:$CLOUD_COMPUTER_KUBECONFIGS \
  --volume $CLOUD_COMPUTER_TERRAFORM_VOLUME:$CLOUD_COMPUTER_TERRAFORM \
  --workdir $CLOUD_COMPUTER_BACKEND/infrastructure/terraform/cloud-computer \
  cloud-computer/cloud-computer:latest \
  terraform "$@"
