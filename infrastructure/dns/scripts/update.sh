# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Point cloud computer dns to terraform host
yarn set-record *.$CLOUD_COMPUTER_HOST_DNS $(yarn --cwd ../terraform ip)

exit 3
