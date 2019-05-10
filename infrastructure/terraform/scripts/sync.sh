echo 11111111111111111

# Initialize backend
yarn terraform init $(yarn workdir)

echo 22222222222222222

# Sync with remote terraform state in cloud storage
yarn terraform refresh $(yarn workdir)

echo 33333333333333333
