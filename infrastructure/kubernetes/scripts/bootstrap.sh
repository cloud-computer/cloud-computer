# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create a kind kubernetes cluster
yarn kind create cluster \
  --name cloud-computer

# Move kind kubeconfig to CLOUD_COMPUTER_KUBERNETES_VOLUME
yarn kube-env cp $HOME/.kube/kind-config-cloud-computer $CLOUD_COMPUTER_KUBERNETES/kubeconfig

# Bootstrap helm
yarn --cwd ../helm bootstrap

# Install etcd for compose-on-kubernetes
yarn --cwd ../helm helm install \
  --name etcd-operator stable/etcd-operator \
  --namespace compose

# Start compose etcd
yarn kubectl apply -f kind-compose-etcd.yaml

# Start compose-on-kubernetes
yarn compose-on-kubernetes \
  -namespace=compose \
  -etcd-servers=http://compose-etcd-client:2379 \
  -tag=v0.4.18
