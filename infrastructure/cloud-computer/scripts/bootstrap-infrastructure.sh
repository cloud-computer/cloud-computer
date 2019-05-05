# Export cloud computer shell environment
eval "$(yarn environment)"

# Install yarn shim
yarn --cwd ../yarn link:global

# Clear the shell resolve history to enable the yarn shim
hash -r

# Bootstrap certificates configuration
yarn --cwd ../certificates bootstrap &

# Bootstrap credentials configuration
yarn --cwd ../credentials bootstrap &

# Bootstrap docker configuration
yarn --cwd ../docker bootstrap &

# Bootstrap git configuration
yarn --cwd ../git bootstrap &

# Bootstrap yarn configuration
yarn --cwd ../yarn bootstrap &

# Create the CLOUD_COMPUTER_CODE volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_CODE_VOLUME:$CLOUD_COMPUTER_CODE \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_CODE &

# Create the CLOUD_COMPUTER_GITHUB volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_GITHUB_VOLUME:$CLOUD_COMPUTER_GITHUB \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_GITHUB &

# Create the CLOUD_COMPUTER_HOME volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_HOME_VOLUME:$CLOUD_COMPUTER_HOME \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_HOME &

# Create the CLOUD_COMPUTER_NODEMON volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_NODEMON_VOLUME:$CLOUD_COMPUTER_NODEMON \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_NODEMON &

# Create the CLOUD_COMPUTER_TMUX volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_TMUX_VOLUME:$CLOUD_COMPUTER_TMUX \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_TMUX &

# Create the CLOUD_COMPUTER_X11 volume and take ownership of it
yarn --cwd ../docker docker run \
  --rm \
  --user root \
  --volume $CLOUD_COMPUTER_X11_VOLUME:$CLOUD_COMPUTER_X11 \
  cloudnativecomputer/cloud-computer:latest \
  chown -R cloud:cloud $CLOUD_COMPUTER_X11 &

# Wait for ownership changes to complete in parallel
wait

# Clone repositories into docker volumes
yarn --cwd ../git clone

# Bootstrap terraform configuration
yarn --cwd ../terraform bootstrap
