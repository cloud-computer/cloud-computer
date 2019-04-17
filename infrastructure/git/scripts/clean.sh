# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Point shell context to the local docker host
export $(DOCKER_HOST=localhost yarn --cwd ../docker environment); 

# Remove cloned repositories
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --volume $CLOUD_COMPUTER_CODE_SERVER_VOLUME:$CLOUD_COMPUTER_CODE_SERVER \
  --volume $CLOUD_COMPUTER_FRONTEND_VOLUME:$CLOUD_COMPUTER_FRONTEND \
  --volume $CLOUD_COMPUTER_SLACKBOT_VOLUME:$CLOUD_COMPUTER_SLACKBOT \
  cloud-computer/cloud-computer:latest \
  zsh -c "\
    find $CLOUD_COMPUTER_BACKEND $CLOUD_COMPUTER_CODE_SERVER $CLOUD_COMPUTER_FRONTEND $CLOUD_COMPUTER_SLACKBOT | \
    grep -vE \"($CLOUD_COMPUTER_BACKEND|$CLOUD_COMPUTER_CODE_SERVER|$CLOUD_COMPUTER_FRONTEND|$CLOUD_COMPUTER_SLACKBOT)$\" | \
    xargs rm -rf"
