# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Create the static ip before creating the host
yarn terraform apply -target=google_compute_address.cloud-computer $(yarn workdir)

# Point dns to cloud computer ip
yarn --cwd ../dns update

# Create the cloud computer host
yarn terraform apply $(yarn workdir)
