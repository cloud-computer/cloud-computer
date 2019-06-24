# Bootstrap remote infrastructure tools
yarn bootstrap:infrastructure

# Bootstrap kubernetes on the cloud computer
yarn --cwd ../kubernetes bootstrap

# Bootstrap the cloud computer repository
yarn exec:terminal yarn bootstrap
