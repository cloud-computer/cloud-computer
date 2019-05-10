# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create the static ip before creating the host
yarn terraform apply -target=google_compute_address.cloud-computer $(yarn workdir)

# Point dns to cloud computer ip
yarn --cwd ../dns update

# Create the cloud computer host
yarn terraform apply $(yarn workdir)

# Wait for host to become accessible by dns
# until curl --output /dev/null --silent https://terminal.$CLOUD_COMPUTER_HOST_DNS; do
#   echo "Waiting for cloud computer to become accessible by DNS..."
#   sleep 5
# done
