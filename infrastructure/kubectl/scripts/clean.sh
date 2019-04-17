# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Point shell context to the local docker host
export $(DOCKER_HOST=localhost yarn --cwd ../docker environment); 

# Remove all files in the CLOUD_COMPUTER_KUBECONFIGS volume
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_KUBECONFIGS_VOLUME:$CLOUD_COMPUTER_KUBECONFIGS \
  cloud-computer/cloud-computer:latest \
  zsh -c "rm -rf $CLOUD_COMPUTER_KUBECONFIGS/*"
