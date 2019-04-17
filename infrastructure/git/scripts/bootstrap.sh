# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Create the CLOUD_COMPUTER_BACKEND volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  cloud-computer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_BACKEND &

# Create the CLOUD_COMPUTER_CODE_SERVER volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_CODE_SERVER_VOLUME:$CLOUD_COMPUTER_CODE_SERVER \
  cloud-computer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_CODE_SERVER &

# Create the CLOUD_COMPUTER_FRONTEND volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_FRONTEND_VOLUME:$CLOUD_COMPUTER_FRONTEND \
  cloud-computer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_FRONTEND &

# Create the CLOUD_COMPUTER_SLACKBOT volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_SLACKBOT_VOLUME:$CLOUD_COMPUTER_SLACKBOT \
  cloud-computer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_SLACKBOT &

# Wait for ownership changes to complete in parallel
wait
