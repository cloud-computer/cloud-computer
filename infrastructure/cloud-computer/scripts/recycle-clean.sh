# Point shell context to the current environment's terraform host
eval "$(yarn --cwd ../terraform environment)"

# Recreate the cloud computer host
yarn --cwd ../terraform restart

# Prepare the cloud computer on the new host
yarn start
