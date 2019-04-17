# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_YARN_VOLUME:$CLOUD_COMPUTER_YARN \
  cloud-computer/cloud-computer:latest \
  tail -f $CLOUD_COMPUTER_YARN/trace.log
