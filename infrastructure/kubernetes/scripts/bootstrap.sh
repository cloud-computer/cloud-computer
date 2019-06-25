# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create a kind kubernetes cluster and move kubeconfig to CLOUD_COMPUTER_KUBERNETES_VOLUME
yarn kube-run zsh -c "\
  kind create cluster --name cloud-computer && \
  mv $HOME/.kube/kind-config-cloud-computer $CLOUD_COMPUTER_KUBERNETES/kubeconfig"

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

# Create the istio-system namespace
yarn kubectl create namespace istio-system

# Generate istio install template
yarn --cwd ../helm helm template install/kubernetes/helm/istio \
  --name istio \ 
  --set global.mtls.enabled=false \
  --set tracing.enabled=true \ 
  --set kiali.enabled=true \
  --set grafana.enabled=true \
  --namespace istio-system > $CLOUD_COMPUTER_KUBERNETES/istio.yaml

# Install istio
yarn kubectl apply -f $CLOUD_COMPUTER_KUBERNETES/istio.yaml
