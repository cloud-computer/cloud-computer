# Export stemn shell environment
export $(yarn --cwd infrastructure/development-environment environment)

# Prompt which app to open in app mode
yarn apps | \
  tr \  \\n | \
  yarn ipt | \
  xargs -n 1 -I% nohup google-chrome --app=https://%-$STEMN_HOST_DNS >/dev/null 2>&1
