# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Add a mapping to the terraform host
yarn set-host $CLOUD_COMPUTER_HOST_DNS $(yarn --cwd ../terraform ip)
