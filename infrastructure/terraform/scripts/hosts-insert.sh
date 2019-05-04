# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Add a mapping to the terraform host
yarn --cwd ../hosts set-host $CLOUD_COMPUTER_HOST_DNS $(yarn --cwd ../terraform ip --no-cache)
