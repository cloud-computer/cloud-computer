# Export cloud computer shell environment
eval "$(yarn --cwd ../../infrastructure/cloud-computer environment)"

# Export webapp shell environment
eval "$(yarn environment)"

# Start the docker-compose stack
docker-compose up -d
