DOCKER_HOST_IP=$(yarn --cwd ../terraform ip)

# Extract VIRTUAL_HOST tags from each docker compose service
DOCKER_COMPOSE_HOSTS=$(yarn hosts)

# Add each VIRTUAL_HOST to the hosts file
for VIRTUAL_HOST in $DOCKER_COMPOSE_HOSTS; do
  yarn --cwd ../cloudflare set-record $VIRTUAL_HOST $DOCKER_HOST_IP &
done

# Wait for hosts to update in parallel
wait
