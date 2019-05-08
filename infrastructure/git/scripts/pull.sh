# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Local repository branch
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Clone cloud-computer backend repository
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --workdir $CLOUD_COMPUTER_BACKEND \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  git pull &

# Clone cloud-computer frontend repository
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_FRONTEND_VOLUME:$CLOUD_COMPUTER_FRONTEND \
  --workdir $CLOUD_COMPUTER_FRONTEND \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  git pull &

# Clone cloud-computer slackbot repository
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_SLACKBOT_VOLUME:$CLOUD_COMPUTER_SLACKBOT \
  --workdir $CLOUD_COMPUTER_SLACKBOT \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  git pull &

# Wait for pulls to complete in parallel
wait
