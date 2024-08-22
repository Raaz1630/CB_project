#!/bin/bash

# Name of the Docker container 
CONTAINER_NAME="sonarqube"

# Check if the Docker container is running 
RUNNING=$(docker inspect --format="{{ .State. Running }}" $CONTAINER_NAME 2>/dev/null)

# If the container is not running, start it
if [ "$RUNNING" != "true" ]; then
  echo "Container $CONTAINER_NAME is not running. Starting container..."
  docker start $CONTAINER_NAME 
else
  echo "Container $CONTAINER_NAME is already running."
fi