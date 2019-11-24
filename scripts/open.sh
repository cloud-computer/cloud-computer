# Export cloud computer dns environment
eval "$(yarn --cwd infrastructure/dns environment)"

# Prompt which app to open in app mode
yarn apps | \
  tr \  \\n | \
  yarn ipt | \
  xargs -n 1 -I% nohup google-chrome --app=https://%.$CLOUD_COMPUTER_DNS_DOMAIN >/dev/null 2>&1
