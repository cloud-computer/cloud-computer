# Exclude changes to secrets from repository history
yarn --cwd infrastructure/git ignore-changes ../../infrastructure/credentials/cloud-provider.json
