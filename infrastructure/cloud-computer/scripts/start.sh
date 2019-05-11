# Export cloud computer shell environment
eval "$(yarn environment)"

# Bootstrap the cloud computer host
yarn bootstrap:remote-host

# Deploy the cloud computer containers
yarn --cwd ../docker-compose up

# Start the cloud computer services
# yarn exec:terminal yarn --cwd infrastructure/cloud-computer yarn services:start
yarn exec:terminal yarn --cwd infrastructure/cloud-computer yarn tmux:gotty:start

echo HOSTNAME $HOSTNAME
yarn exec:terminal zsh -c 'echo HOSTNAMEXXXXXXXX $HOSTNAME; hostname'
yarn exec:terminal zsh -c hostname
echo XXXXXXX DONE
