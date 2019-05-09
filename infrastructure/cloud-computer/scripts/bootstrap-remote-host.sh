# Bootstrap remote infrastructure tools
yarn bootstrap:infrastructure

# Start a terminal in the cloud computer
yarn --cwd ../docker-compose up:terminal

# Bootstrap the cloud computer repository
yarn exec:terminal yarn bootstrap
