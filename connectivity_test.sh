#!/bin/bash

COMMAND=$(ssh -o StrictHostKeyChecking=no docker_root@container2 -i /home/docker_root/.ssh/id_rsa hostname)

if [ "$COMMAND" == "container2" ]; then
  echo "All good"
  exit 0
else
  echo "Cannot connect to container2"
  exit 1
fi
