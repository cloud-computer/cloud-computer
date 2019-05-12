# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Local repository branch
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Clone cloud-computer backend repository (unknown issue: git clone causes root ownership of repository volume)
yarn --cwd ../docker docker run \
  --rm \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --user root \
  --workdir $CLOUD_COMPUTER_REPOSITORY \
  $CLOUD_COMPUTER_IMAGE \
  zsh -c "git clone https://github.com/cloud-computer/cloud-computer.git --branch $GIT_BRANCH --single-branch .; chown -R cloud:cloud ." 2>/dev/null
