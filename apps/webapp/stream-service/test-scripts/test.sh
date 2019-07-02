#!/bin/bash

echo "Provisioning..."
docker run -d -p 6379:6379 --rm --name redis-test redis
cd test-scripts && docker build -t=my-test .
echo "Done creating redis box"