# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Initialize backend
yarn terraform init

# Sync with remote terraform state in cloud storage
yarn terraform refresh
