# Export cloud computer dns environment
eval "$(yarn environment)"

# Point cloud computer dns to terraform host
yarn set-record $CLOUD_COMPUTER_DNS_NAME $(yarn --cwd ../terraform ip)
yarn set-record *.$CLOUD_COMPUTER_DNS_NAME $(yarn --cwd ../terraform ip)
