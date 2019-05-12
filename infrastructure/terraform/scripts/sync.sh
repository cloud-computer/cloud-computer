# Initialize backend
yarn terraform init $(yarn workdir)

# Sync with remote terraform state in cloud storage
yarn terraform refresh $(yarn workdir)
