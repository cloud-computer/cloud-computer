#!/bin/sh

# Set cloud computer environment
export CLOUD_COMPUTER_BACKEND=${var.CLOUD_COMPUTER_BACKEND}
export CLOUD_COMPUTER_BACKEND_VOLUME=${var.CLOUD_COMPUTER_BACKEND_VOLUME}
export CLOUD_COMPUTER_HOST_ID=${var.CLOUD_COMPUTER_HOST_ID}

# Target the local docker socket
export DOCKER_HOST=unix:///var/run/docker.sock

# Alias docker run
alias docker_run="docker run --env CLOUD_COMPUTER_HOST_ID --env DOCKER_HOST --rm --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND --volume /var/run/docker.sock:/var/run/docker.sock --workdir $CLOUD_COMPUTER_BACKEND ${var.CLOUD_COMPUTER_REPOSITORY}/bootstrap"

# Clone the cloud computer
docker_run git clone --branch master --depth 1 --quiet --single-branch https://github.com/cloud-computer/cloud-computer $CLOUD_COMPUTER_BACKEND

# Expose the docker socket
docker_run yarn --cwd infrastructure/docker-compose up:docker
docker_run yarn --cwd infrastructure/docker-compose up:traefik
