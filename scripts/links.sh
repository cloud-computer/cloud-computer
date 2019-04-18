# Export stemn shell environment
export $(yarn --cwd infrastructure/development-environment environment)

# Print links for click-to-open access
echo
yarn apps | \
  tr \  \\n | \
  xargs -n 1 -I% echo https://%-$STEMN_HOST_DNS
