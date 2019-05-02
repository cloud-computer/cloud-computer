# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

CLOUD_COMPUTER_DEVELOPMENT_ENVIRONMENT_IP=$(yarn --cwd ../terraform ip --no-cache)

# Add a mapping to the terraform host
yarn --cwd ../hosts set-host $CLOUD_COMPUTER_HOST_DNS $CLOUD_COMPUTER_DEVELOPMENT_ENVIRONMENT_IP
