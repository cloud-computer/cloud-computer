# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Generic docker run with kubernetes specific volumes
yarn --cwd ../docker docker run \
  --env KUBECONFIG=$CLOUD_COMPUTER_KUBERNETES_VOLUME/kubeconfig \
  --rm \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $CLOUD_COMPUTER_KUBERNETES_VOLUME:$CLOUD_COMPUTER_KUBERNETES \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --workdir $CLOUD_COMPUTER_REPOSITORY \
  $CLOUD_COMPUTER_IMAGE \
  "$@"
