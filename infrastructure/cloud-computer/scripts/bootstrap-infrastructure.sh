# Export cloud computer shell environment
eval "$(yarn environment)"

# Install yarn dependencies
yarn install

# Install yarn shim
yarn --cwd ../yarn link:global

# Clear the shell resolve history to enable the yarn shim
hash -r

# Bootstrap credentials configuration
yarn --cwd ../credentials bootstrap &

# Bootstrap dns configuration
yarn --cwd ../dns bootstrap &

# Bootstrap git configuration
yarn --cwd ../git bootstrap &

# Bootstrap yarn configuration
yarn --cwd ../yarn bootstrap &

# Create the CLOUD_COMPUTER_HOME volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_HOME_VOLUME:$CLOUD_COMPUTER_HOME \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_HOME &

# Create the CLOUD_COMPUTER_NODEMON volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_NODEMON_VOLUME:$CLOUD_COMPUTER_NODEMON \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_NODEMON &

# Create the CLOUD_COMPUTER_TMUX volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_TMUX_VOLUME:$CLOUD_COMPUTER_TMUX \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_TMUX &

# Create the CLOUD_COMPUTER_X11 volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_X11_VOLUME:$CLOUD_COMPUTER_X11 \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_X11 &

# Wait for ownership changes to complete in parallel
wait

# Clone repositories into docker volumes
yarn --cwd ../git clone

# Bootstrap terraform configuration
yarn --cwd ../terraform bootstrap
