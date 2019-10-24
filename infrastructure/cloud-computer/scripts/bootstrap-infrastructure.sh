# Export cloud computer shell environment
eval "$(yarn environment)"

# Install yarn dependencies
yarn install

# Install yarn shim
# yarn --cwd ../yarn link:global

# Clear the shell resolve history to enable the yarn shim
# hash -r

# Bootstrap cloudstorage configuration
yarn --cwd ../cloudstorage bootstrap &

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
  --volume CLOUD_COMPUTER_HOME:$CLOUD_COMPUTER_HOME \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_HOME &

# Create the CLOUD_COMPUTER_NODEMON volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_NODEMON:$CLOUD_COMPUTER_NODEMON \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_NODEMON &

# Create the CLOUD_COMPUTER_TMUX volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_TMUX:$CLOUD_COMPUTER_TMUX \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_TMUX &

# Create the CLOUD_COMPUTER_X11 volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_X11:$CLOUD_COMPUTER_X11 \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_X11 &

# Create the CLOUD_COMPUTER_CACHE_CHROME volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_CACHE_CHROME:$CLOUD_COMPUTER_CACHE_CHROME \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_CACHE_CHROME &

# Create the CLOUD_COMPUTER_CACHE_CODE volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_CACHE_CODE:$CLOUD_COMPUTER_CACHE_CODE \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_CACHE_CODE &

# Create the CLOUD_COMPUTER_CACHE_TMUX volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_CACHE_TMUX:$CLOUD_COMPUTER_CACHE_TMUX \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_CACHE_TMUX &

# Create the CLOUD_COMPUTER_CACHE_YARN volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_CACHE_YARN:$CLOUD_COMPUTER_CACHE_YARN \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_CACHE_YARN &

# Create the CLOUD_COMPUTER_CACHE_ZSH volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_CACHE_ZSH:$CLOUD_COMPUTER_CACHE_ZSH \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_CACHE_ZSH &

# Create the CLOUD_COMPUTER_STATE_CHROME volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_STATE_CHROME:$CLOUD_COMPUTER_STATE_CHROME \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_STATE_CHROME &

# Create the CLOUD_COMPUTER_STATE_CODE volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_STATE_CODE:$CLOUD_COMPUTER_STATE_CODE \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_STATE_CODE &

# Create the CLOUD_COMPUTER_STATE_I3 volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_STATE_I3:$CLOUD_COMPUTER_STATE_I3 \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_STATE_I3 &

# Create the CLOUD_COMPUTER_STATE_JUMP volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_STATE_JUMP:$CLOUD_COMPUTER_STATE_JUMP \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_STATE_JUMP &

# Create the CLOUD_COMPUTER_STATE_SLACK volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume CLOUD_COMPUTER_STATE_SLACK:$CLOUD_COMPUTER_STATE_SLACK \
  $CLOUD_COMPUTER_IMAGE \
  chown -R cloud:cloud $CLOUD_COMPUTER_STATE_SLACK &

# Wait for bootstraps to complete in parallel
wait

# Clone cloud computer repository into docker volume
yarn --cwd ../git clone

# Bootstrap credentials configuration in git repository docker volume
yarn --cwd ../credentials bootstrap

# Bootstrap terraform configuration
yarn --cwd ../terraform bootstrap
