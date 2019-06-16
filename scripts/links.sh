# Export cloud computer shell environment
eval "$(yarn --cwd infrastructure/cloud-computer environment)"

# Print link for click-to-open access
echo
echo https://$CLOUD_COMPUTER_HOST_DNS
echo
