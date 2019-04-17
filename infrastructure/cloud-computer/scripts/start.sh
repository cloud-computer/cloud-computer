# Export cloud computer shell environment
export $(yarn environment)

# Bootstrap the cloud computer host
yarn bootstrap:remote-host

# Deploy the cloud computer containers
yarn --cwd ../docker-compose start

# Start the cloud computer services
yarn exec:tty:terminal yarn --cwd infrastructure/cloud-computer yarn services:start
