# Point shell context to the current environment's terraform host
eval "$(yarn --cwd ../terraform environment)"

# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Always connect to localhost via the unix socket
if [ "$DOCKER_HOST" = "localhost" ]; then

  DOCKER_CERT_PATH=
  DOCKER_HOST=unix:///var/run/docker.sock
  DOCKER_TLS_VERIFY=

elif [ -z "$DOCKER_HOST" ]; then

  # Use tls when connecting to a remote host
  DOCKER_CERT_PATH=$PWD/../certificates
  DOCKER_HOST=$TERRAFORM_TARGET-$CLOUD_COMPUTER_HOST_DNS:2375
  DOCKER_TLS_VERIFY=1

fi

echo export DOCKER_CERT_PATH=$DOCKER_CERT_PATH
echo export DOCKER_HOST=$DOCKER_HOST
echo export DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY
