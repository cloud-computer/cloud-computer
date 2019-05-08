# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

if [ "$DOCKER_HOST" = "localhost" ]; then

  # Always connect to localhost via the unix socket
  docker \
    --host unix:///var/run/docker.sock \
    "$@"

elif [ -z "$DOCKER_HOST" ]; then

  # Use tls when connecting to a remote host
  docker \
    --host docker.$CLOUD_COMPUTER_HOST_DNS:443 \
    --tlsverify=false \
    "$@"
fi
