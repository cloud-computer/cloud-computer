# Export cloud computer shell environment
eval "$(yarn environment)"

# Install yarn dependencies
yarn install

# Install yarn shim
yarn --cwd ../yarn link:global

# Clear the shell resolve history to enable the yarn shim
hash -r

echo 1111111111111111111111111111111111111

# Bootstrap credentials configuration
yarn --cwd ../credentials bootstrap

echo 2222222222222222222222222222222222222

# Bootstrap dns configuration
yarn --cwd ../dns bootstrap

echo 3333333333333333333333333333333333333

# Bootstrap git configuration
yarn --cwd ../git bootstrap

echo 4444444444444444444444444444444444444

# Bootstrap yarn configuration
yarn --cwd ../yarn bootstrap

echo 5555555555555555555555555555555555555

# Create the CLOUD_COMPUTER_HOME volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_HOME_VOLUME:$CLOUD_COMPUTER_HOME \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_HOME

echo 6666666666666666666666666666666666666

# Create the CLOUD_COMPUTER_NODEMON volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_NODEMON_VOLUME:$CLOUD_COMPUTER_NODEMON \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_NODEMON

echo 7777777777777777777777777777777777777

# Create the CLOUD_COMPUTER_TMUX volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_TMUX_VOLUME:$CLOUD_COMPUTER_TMUX \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_TMUX

echo 8888888888888888888888888888888888888

# Create the CLOUD_COMPUTER_X11 volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_X11_VOLUME:$CLOUD_COMPUTER_X11 \
  $CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_X11

echo 9999999999999999999999999999999999999

# Wait for bootstraps to complete in parallel
# wait

# Clone cloud computer repository into docker volume
yarn --cwd ../git clone

echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# Bootstrap terraform configuration
yarn --cwd ../terraform bootstrap

echo YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
