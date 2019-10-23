# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Export cloud computer git environment
eval "$(yarn --cwd ../git environment)"

# Clone cloud-computer backend repository (unknown issue: git clone causes root ownership of repository volume)
yarn --cwd ../docker docker run \
  --rm \
  --volume CLOUD_COMPUTER_REPOSITORY:$CLOUD_COMPUTER_REPOSITORY \
  --user root \
  --workdir $CLOUD_COMPUTER_REPOSITORY \
  $CLOUD_COMPUTER_IMAGE \
  zsh -c "git clone $CLOUD_COMPUTER_GIT_URL $CLOUD_COMPUTER_REPOSITORY; chown -R cloud:cloud .; git checkout $CLOUD_COMPUTER_GIT_BRANCH" 2>/dev/null
