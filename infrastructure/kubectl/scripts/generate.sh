# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point shell context to the local docker host
eval "$(DOCKER_HOST=localhost yarn --cwd ../docker environment)"

# Prepare kubectl
yarn bootstrap

# Make kubectl always target the cloud computer
TERRAFORM_TARGET=cloud-computer

# Set cluster TERRAFORM_TARGET to use CLOUD_COMPUTER_CERTIFICATES
yarn kubectl config set-cluster $TERRAFORM_TARGET \
  --certificate-authority=$CLOUD_COMPUTER_CERTIFICATES/ca.pem \
  --embed-certs=true \
  --server=https://$TERRAFORM_TARGET-$CLOUD_COMPUTER_HOST_DNS:6443

# Set credentials for admin user to CLOUD_COMPUTER_CERTIFICATES
yarn kubectl config set-credentials admin \
  --client-certificate=$CLOUD_COMPUTER_CERTIFICATES/cert.pem \
  --client-key=$CLOUD_COMPUTER_CREDENTIALS/cloud-computer.prv

# Set default TERRAFORM_TARGET cluster user to admin
yarn kubectl config set-context $TERRAFORM_TARGET \
  --cluster=$TERRAFORM_TARGET \
  --user=admin

# Set default config to TERRAFORM_TARGET
yarn kubectl config use-context $TERRAFORM_TARGET
