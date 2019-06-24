# Create a kind kubernetes cluster
yarn kind create cluster \
  --name cloud-computer

# Bootstrap helm
yarn --cwd ../helm bootstrap

# Install etcd for compose-on-kubernetes
yarn --cwd ../helm helm install \
  --name etcd-operator stable/etcd-operator \
  --namespace compose

# Start compose etcd
yarn kubectl apply -f kind-compose-etcd.yaml
