# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create a kind kubernetes cluster
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_KUBERNETES_VOLUME:$CLOUD_COMPUTER_KUBERNETES \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --workdir $CLOUD_COMPUTER_REPOSITORY \
  $CLOUD_COMPUTER_IMAGE \
  kind create cluster \
  --name cloud-computer

# Bootstrap helm
yarn --cwd ../helm bootstrap

# Install etcd for compose-on-kubernetes
yarn --cwd ../helm helm install \
  --name etcd-operator stable/etcd-operator \
  --namespace compose

# Start compose etcd
yarn kubectl apply -f kind-compose-etcd.yaml

# Start compose-on-kubernetes
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_KUBERNETES_VOLUME:$CLOUD_COMPUTER_KUBERNETES \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --workdir $CLOUD_COMPUTER_REPOSITORY \
  $CLOUD_COMPUTER_IMAGE \
  compose-on-kubernetes \
  -namespace=compose \
  -etcd-servers=http://compose-etcd-client:2379 \
  -tag=v0.4.18
