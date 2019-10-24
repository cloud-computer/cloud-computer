# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Export cloud computer git environment
eval "$(yarn --cwd ../git environment)"

# Create a unique sync identifier
SYNC_CONTAINER=cloud-computer-sync-$HOSTNAME-$(date +%M%S)

# Sync to the CLOUD_COMPUTER_REPOSITORY volume using a temporary container
yarn --cwd ../docker docker run \
  --detach \
  --name $SYNC_CONTAINER \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume CLOUD_COMPUTER_REPOSITORY:$CLOUD_COMPUTER_REPOSITORY \
  --workdir $CLOUD_COMPUTER_REPOSITORY \
  $CLOUD_COMPUTER_IMAGE \
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
      git checkout $CLOUD_COMPUTER_GIT_BRANCH; \
      git pull"
fi

# Stream git changes from local machine to development ennvironment
git status --porcelain | \
  sed -E 's;.{3};\./;' | \
  tar --directory ../.. --files-from - -cvO | \
  yarn --cwd ../docker docker exec --interactive $SYNC_CONTAINER \
  tar Cxf $CLOUD_COMPUTER_REPOSITORY -

# Remove the temporary sync container
yarn --cwd ../docker docker rm -f $SYNC_CONTAINER

# Trigger nodemon restart after sync
yarn --cwd ../cloud-computer nodemon:restart
