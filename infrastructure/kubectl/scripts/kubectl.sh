# Point shell context to the current environment's terraform host
export $(yarn --cwd ../terraform environment)

# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Point shell context to the local docker host
export $(DOCKER_HOST=localhost yarn --cwd ../docker environment)

# Provide the ip address of the cloud computer to kubectl
CLOUD_COMPUTER_DEVELOPMENT_ENVIRONMENT_IP=$(yarn --cwd ../terraform ip)

yarn --cwd ../docker docker run \
  --env KUBECONFIG=$CLOUD_COMPUTER_KUBECONFIGS/$TERRAFORM_TARGET \
  --interactive \
  --rm \
  --tty \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --volume $CLOUD_COMPUTER_CERTIFICATES_VOLUME:$CLOUD_COMPUTER_CERTIFICATES \
  --volume $CLOUD_COMPUTER_KUBECONFIGS_VOLUME:$CLOUD_COMPUTER_KUBECONFIGS \
  --workdir $CLOUD_COMPUTER_BACKEND \
  cloud-computer/cloud-computer:latest \
  kubectl "$@"
