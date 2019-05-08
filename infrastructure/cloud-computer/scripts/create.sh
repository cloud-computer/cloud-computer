# Bootstrap the local environment for creation of the remote environment
yarn bootstrap:local-host

# Create the cloud computer host
yarn --cwd ../terraform apply
