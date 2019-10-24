sanitise () { echo "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's;[^a-z0-9_-];;g'; }

# Set the cloud computer environment
CLOUD_COMPUTER_CLOUD_PROVIDER=${CLOUD_COMPUTER_CLOUD_PROVIDER-gcp}
CLOUD_COMPUTER_DOMAIN_NAME=${CLOUD_COMPUTER_DOMAIN_NAME-cloud-computer.dev}
CLOUD_COMPUTER_HOST_NAME=${CLOUD_COMPUTER_HOST_NAME-$(sanitise $HOSTNAME)}
CLOUD_COMPUTER_HOST_USER=${CLOUD_COMPUTER_HOST_USER-$(sanitise $USER)}
CLOUD_COMPUTER_HOST_ID=${CLOUD_COMPUTER_HOST_ID-$CLOUD_COMPUTER_HOST_USER}
CLOUD_COMPUTER_IMAGE_NAME=${CLOUD_COMPUTER_IMAGE_NAME-cloud-computer}
CLOUD_COMPUTER_IMAGE_TAG=${CLOUD_COMPUTER_IMAGE_TAG-latest}
CLOUD_COMPUTER_REGION=${CLOUD_COMPUTER_REGION-australia-southeast1}
CLOUD_COMPUTER_REGISTRY=${CLOUD_COMPUTER_REGISTRY-cloudnativecomputer}
CLOUD_COMPUTER_USER_HOME=$HOME/$CLOUD_COMPUTER_HOST_USER

# Cloud computer application cache volumes
echo export CLOUD_COMPUTER_CACHE_CHROME=$CLOUD_COMPUTER_USER_HOME/.cache/google-chrome
echo export CLOUD_COMPUTER_CACHE_CODE=$CLOUD_COMPUTER_USER_HOME/.vscode
echo export CLOUD_COMPUTER_CACHE_TMUX=$CLOUD_COMPUTER_USER_HOME/.tmux
echo export CLOUD_COMPUTER_CACHE_YARN=$CLOUD_COMPUTER_USER_HOME/.cache/yarn
echo export CLOUD_COMPUTER_CACHE_ZSH=$CLOUD_COMPUTER_USER_HOME/.cache/zsh

# Cloud computer application state volumes
echo export CLOUD_COMPUTER_STATE_CHROME=$CLOUD_COMPUTER_USER_HOME/.config/google-chrome
echo export CLOUD_COMPUTER_STATE_CODE=$CLOUD_COMPUTER_USER_HOME/.config/Code
echo export CLOUD_COMPUTER_STATE_I3=$CLOUD_COMPUTER_USER_HOME/.i3
echo export CLOUD_COMPUTER_STATE_JUMP=$CLOUD_COMPUTER_USER_HOME/.jump
echo export CLOUD_COMPUTER_STATE_SLACK=$CLOUD_COMPUTER_USER_HOME/.config/Slack

echo export CLOUD_COMPUTER_CLOUD_PROVIDER=$CLOUD_COMPUTER_CLOUD_PROVIDER
echo export CLOUD_COMPUTER_DOMAIN_NAME=$CLOUD_COMPUTER_DOMAIN_NAME
echo export CLOUD_COMPUTER_HOST_DNS=$CLOUD_COMPUTER_HOST_ID.$CLOUD_COMPUTER_DOMAIN_NAME
echo export CLOUD_COMPUTER_HOST_ID=$CLOUD_COMPUTER_HOST_ID
echo export CLOUD_COMPUTER_HOST_NAME=$CLOUD_COMPUTER_HOST_NAME
echo export CLOUD_COMPUTER_HOST_USER=$CLOUD_COMPUTER_HOST_USER
echo export CLOUD_COMPUTER_IMAGE=$CLOUD_COMPUTER_REGISTRY/$CLOUD_COMPUTER_IMAGE_NAME:$CLOUD_COMPUTER_IMAGE_TAG
echo export CLOUD_COMPUTER_REGION=$CLOUD_COMPUTER_REGION
echo export CLOUD_COMPUTER_REGISTRY=$CLOUD_COMPUTER_REGISTRY

echo export CLOUD_COMPUTER_CLOUDSTORAGE=/cloud-computer/cloudstorage
echo export CLOUD_COMPUTER_CREDENTIALS=/cloud-computer/credentials
echo export CLOUD_COMPUTER_HOME=/cloud-computer/home
echo export CLOUD_COMPUTER_NODEMON=/cloud-computer/nodemon
echo export CLOUD_COMPUTER_REPOSITORY=/cloud-computer/cloud-computer
echo export CLOUD_COMPUTER_TERRAFORM=/cloud-computer/terraform
echo export CLOUD_COMPUTER_TMUX=/cloud-computer/tmux
echo export CLOUD_COMPUTER_X11=/tmp/.X11-unix
echo export CLOUD_COMPUTER_YARN=/cloud-computer/yarn

# Traefik oauth
echo export CLOUD_COMPUTER_TRAEFIK_SECRET=$CLOUD_COMPUTER_HOST_USER
echo export CLOUD_COMPUTER_TRAEFIK_GOOGLE_CLIENT_ID=
echo export CLOUD_COMPUTER_TRAEFIK_GOOGLE_CLIENT_SECRET=

# Docker compose
echo export COMPOSE_PROJECT_NAME=cloud-computer
