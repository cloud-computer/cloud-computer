# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Export local git config
eval "$(yarn --cwd ../git environment)"

yarn --cwd ../docker docker run \
  --env COMPOSE_PROJECT_NAME \
  --env GIT_AUTHOR_EMAIL \
  --env GIT_AUTHOR_NAME \
  --env CLOUD_COMPUTER_CREDENTIALS \
  --env CLOUD_COMPUTER_HOME \
  --env CLOUD_COMPUTER_HOST_DNS \
  --env CLOUD_COMPUTER_HOST_ID \
  --env CLOUD_COMPUTER_HOST_NAME \
  --env CLOUD_COMPUTER_HOST_USER \
  --env CLOUD_COMPUTER_IMAGE \
  --env CLOUD_COMPUTER_NODEMON \
  --env CLOUD_COMPUTER_REPOSITORY \
  --env CLOUD_COMPUTER_TERRAFORM \
  --env CLOUD_COMPUTER_TMUX \
  --env CLOUD_COMPUTER_X11 \
  --env CLOUD_COMPUTER_YARN \
  --env CLOUD_COMPUTER_YARN_JAEGER_TRACE \
  --interactive \
  --rm \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY \
  --workdir $CLOUD_COMPUTER_REPOSITORY/infrastructure/docker-compose \
  wernight/docker-compose "$@"
