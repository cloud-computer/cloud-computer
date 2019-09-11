# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Bootstrap packer configuration
yarn bootstrap

# Build the packer image
yarn packer build -force providers/$CLOUD_COMPUTER_CLOUD_PROVIDER.json
