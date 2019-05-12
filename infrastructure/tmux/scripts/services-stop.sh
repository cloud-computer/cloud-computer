# Export cloud computer shell environment
eval "$(yarn environment)"

# Stop the cloud computer terminal dashboard
yarn dashboard:stop

# Stop the cloud computer terminal web interface
yarn gotty:stop
