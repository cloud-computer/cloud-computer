# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Add a wildcard dns entry for the terraform host
yarn set-host *.$CLOUD_COMPUTER_HOST_DNS $(yarn --cwd ../terraform ip)
