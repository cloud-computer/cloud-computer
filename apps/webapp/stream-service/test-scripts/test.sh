#!/bin/bash

echo "Provisioning..."
docker run -d -p 6379:6379 --rm --name redis-test redis

echo "Just wait"
sleep 5

cd test-scripts && docker build -t=my-test .
echo "Done creating redis box"