# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Local repository branch
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Remove all files in the destination otherwise git errors with "destination is not an empty directory"
GIT_CLEAN="test -d .git || find . -mindepth 1 -delete"

# Commands to restore refs for shallow clones
GIT_FETCH="git config remote.origin.fetch \"+refs/heads/*:refs/remotes/origin/*\"; git fetch --depth 1"

# Take ownership after cloning as root
TAKE_OWNERSHIP="chown -R cloud:cloud ."

# Clone cloud-computer backend repository
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND \
  --workdir $CLOUD_COMPUTER_BACKEND \
  $CLOUD_COMPUTER_REPOSITORY/$CLOUD_COMPUTER_IMAGE:latest \
  zsh -c "$GIT_CLEAN; git clone https://github.com/cloud-computer/cloud-computer.git --branch $GIT_BRANCH --depth 1 --single-branch .; $GIT_FETCH; $TAKE_OWNERSHIP" &

# Clone cloud-computer frontend repository
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_FRONTEND_VOLUME:$CLOUD_COMPUTER_FRONTEND \
  --workdir $CLOUD_COMPUTER_FRONTEND \
  $CLOUD_COMPUTER_REPOSITORY/$CLOUD_COMPUTER_IMAGE:latest \
  zsh -c "$GIT_CLEAN; git clone https://github.com/cloud-computer/frontend.git --branch master --depth 1 --single-branch .; $GIT_FETCH; $TAKE_OWNERSHIP" &

# Clone cloud-computer slackbot repository
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_SLACKBOT_VOLUME:$CLOUD_COMPUTER_SLACKBOT \
  --workdir $CLOUD_COMPUTER_SLACKBOT \
  $CLOUD_COMPUTER_REPOSITORY/$CLOUD_COMPUTER_IMAGE:latest \
  zsh -c "$GIT_CLEAN; git clone https://github.com/cloud-computer/slackbot.git --depth 1 .; $GIT_FETCH; $TAKE_OWNERSHIP" &

# Wait for clones to complete in parallel
wait

# Sync local changes to cloud-computer after cloning
yarn --cwd ../cloud-computer sync
