# Create the tiller service account
yarn --cwd ../kubernetes kubectl \
  --namespace kube-system \
  create serviceaccount tiller

# Create the tiller service account admin role binding
yarn --cwd ../kubernetes kubectl \
  --namespace kube-system \
  create clusterrolebinding tiller \
  --clusterrole cluster-admin \
  --serviceaccount kube-system:tiller

# Configure helm to use the tiller admin account
yarn helm init \
  --service-account tiller
