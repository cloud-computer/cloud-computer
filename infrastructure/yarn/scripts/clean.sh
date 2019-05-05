# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Remove the CLOUD_COMPUTER_YARN volume
yarn --cwd ../docker docker volume rm $CLOUD_COMPUTER_YARN_VOLUME
