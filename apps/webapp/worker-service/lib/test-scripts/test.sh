#!/bin/bash

echo "Provisioning..."
docker run -d -p 6800:6379 --rm --name redis-test redis

echo "Just wait"
sleep 5

cd test-scripts && docker build -t=my-test .
echo "Done creating redis box"

pwd

printf "\033[1;31mThis is red text\033[0m\n"
printf "\033[1;31mThis is red text\033[0m\n"
printf "\033[1;31mThis is red text\033[0m\n"
printf "\033[1;31mThis is red text\033[0m\n"
