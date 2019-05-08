# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Apply the terraform configuration
yarn terraform apply

# Update dns to point to terraform host
yarn --cwd ../dns update

# Wait for host to become accessible by dns
until curl --output /dev/null --silent https://terminal.$CLOUD_COMPUTER_HOST_DNS; do
  echo "Waiting for cloud computer to become accessible by DNS..."
  sleep 5
done
