# Export stemn shell environment
eval "$(yarn --cwd infrastructure/development-environment environment)"

# Print links for click-to-open access
echo
yarn apps | \
  tr \  \\n | \
  xargs -n 1 -I% echo https://%-$CLOUD_COMPUTER_HOST_DNS
