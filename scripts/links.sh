# Export cloud computer shell environment
eval "$(yarn --cwd infrastructure/cloud-computer environment)"

# Print links for click-to-open access
echo
yarn apps | \
  tr \  \\n | \
  xargs -n 1 -I% echo https://%.$CLOUD_COMPUTER_HOST_DNS
