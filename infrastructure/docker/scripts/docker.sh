# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

if [ "$DOCKER_HOST" = "localhost" ]; then

  # Always connect to localhost via the unix socket
  DOCKER_CERT_PATH=
  DOCKER_HOST=unix:///var/run/docker.sock
  DOCKER_TLS_VERIFY=

elif [ -z "$DOCKER_HOST" ]; then

  # Use tls when connecting to a remote host
  DOCKER_CERT_PATH=$PWD
  DOCKER_HOST=docker.$CLOUD_COMPUTER_HOST_DNS:2376
  DOCKER_TLS_VERIFY=1

fi

export DOCKER_CERT_PATH=$DOCKER_CERT_PATH
export DOCKER_HOST=$DOCKER_HOST
export DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY

docker "$@"
