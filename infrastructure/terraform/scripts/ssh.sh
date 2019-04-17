# Point shell context to the current environment's terraform host
export $(yarn environment)

# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Point shell context to the local docker host
export $(DOCKER_HOST=localhost yarn --cwd ../docker environment)

# Provide the ip address of the cloud computer to ssh
CLOUD_COMPUTER_DEVELOPMENT_ENVIRONMENT_IP=$(yarn --cwd ../terraform ip)

yarn --cwd ../docker docker run \
  --interactive \
  --rm \
  --tty \
  --volume $CLOUD_COMPUTER_CREDENTIALS_VOLUME:$CLOUD_COMPUTER_CREDENTIALS \
  cloud-computer/cloud-computer:latest \
  ssh \
  -i $CLOUD_COMPUTER_CREDENTIALS/cloud-computer.prv \
  -t \
  $TERRAFORM_TARGET-$CLOUD_COMPUTER_HOST_DNS \
  "$@"
