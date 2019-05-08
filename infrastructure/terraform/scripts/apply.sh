# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Apply the terraform configuration
yarn terraform apply

# Update dns to point to terraform host
yarn --cwd ../dns set-record *.$CLOUD_COMPUTER_HOST_DNS $(yarn ip)

# Wait for host to become accessible by dns
until curl --silent --output /dev/null https://docker.$CLOUD_COMPUTER_HOST_DNS; do sleep 1; done
