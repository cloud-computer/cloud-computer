#!/bin/bash

printf "\033[1;31mProvisioning...\033[0m\n"
cd /cloud-computer/cloud-computer
pwd
echo "building $1"
CLOUD_COMPUTER_HOST_ID=$1 yarn create:cloud-computer
