# Export cloud computer shell environment
eval "$(yarn environment)"

# Remove the CLOUD_COMPUTER_HOME volume
yarn --cwd ../docker docker volume rm $CLOUD_COMPUTER_HOME_VOLUME
