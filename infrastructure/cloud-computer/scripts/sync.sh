# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# The local git branch
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Create a unique sync identifier
SYNC_CONTAINER=${COMPOSE_PROJECT_NAME}-sync-$HOSTNAME-$(date +%M%S)

# Sync to the CLOUD_COMPUTER_BACKEND volume using a temporary container
yarn --cwd ../docker docker run \
  --detach \
  --name $SYNC_CONTAINER \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --workdir $CLOUD_COMPUTER_BACKEND \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  sleep infinity

# Clean the remote environment and pull remote git before syncing locally changed files across
if [ "$1" = "--clean" ]; then
  yarn --cwd ../docker docker exec \
    --interactive \
    --tty \
    $SYNC_CONTAINER zsh -c "\
      git fetch; \
      git cln; \
      git checkout .; \
      git checkout $GIT_BRANCH; \
      git pull"
fi

# Stream git changes from local machine to development ennvironment
git status --porcelain | \
  sed -E 's;.{3};\./;' | \
  tar --directory ../.. --files-from - -cvO | \
  yarn --cwd ../docker docker exec --interactive $SYNC_CONTAINER \
  tar Cxf $CLOUD_COMPUTER_BACKEND -

# Remove the temporary sync container
yarn --cwd ../docker docker rm -f $SYNC_CONTAINER

# Trigger nodemon restart after sync
yarn --cwd ../cloud-computer nodemon:restart
