# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

yarn --cwd ../docker docker run \
  --env HELM_HOME=$CLOUD_COMPUTER_KUBERNETES/helm \
  --rm \
  --volume $CLOUD_COMPUTER_KUBERNETES_VOLUME:$CLOUD_COMPUTER_KUBERNETES \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --workdir $CLOUD_COMPUTER_REPOSITORY \
  $CLOUD_COMPUTER_IMAGE \
  helm "$@"
