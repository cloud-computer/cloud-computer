# Export cloud computer shell environment
eval "$(yarn --cwd infrastructure/cloud-computer environment)"

# Prompt which app to open in app mode
yarn apps | \
  tr \  \\n | \
  yarn ipt | \
  xargs -n 1 -I% nohup google-chrome --app=https://%.$CLOUD_COMPUTER_HOST_DNS >/dev/null 2>&1
