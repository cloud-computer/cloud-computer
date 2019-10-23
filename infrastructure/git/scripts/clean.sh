# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Remove cloned git volumes
yarn --cwd ../docker docker volume rm CLOUD_COMPUTER_REPOSITORY
