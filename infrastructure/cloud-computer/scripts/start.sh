# Export cloud computer shell environment
eval "$(yarn environment)"

# Bootstrap the cloud computer host
yarn bootstrap:remote-host

# Deploy the cloud computer containers
yarn --cwd ../docker-compose up

# Start the cloud computer services
# yarn exec:terminal yarn --cwd infrastructure/tmux yarn services:start
echo ZZZZZZZ PRE
echo ZZZZZZZ PRE
echo ZZZZZZZ PRE
echo ZZZZZZZ PRE
echo ZZZZZZZ PRE
echo ZZZZZZZ PRE
echo ZZZZZZZ PRE
echo ZZZZZZZ PRE

yarn exec:terminal yarn --cwd infrastructure/tmux gotty:start
yarn exec:terminal zsh -c 'echo $HOSTNAME'

echo XXXXXXX DONE
echo XXXXXXX DONE
echo XXXXXXX DONE
echo XXXXXXX DONE
echo XXXXXXX DONE
