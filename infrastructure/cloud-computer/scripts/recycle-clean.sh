# Destroy the current cloud computer host
yarn --cwd ../terraform destroy

# Clean the local host
yarn --cwd ../.. clean

# Create a new cloud computer host
yarn run create
