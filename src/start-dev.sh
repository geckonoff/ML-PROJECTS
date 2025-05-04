#!/bin/bash

echo "I love automatisation"
# Export environment variables from .env file
export $(grep -v '^#' *.env | xargs)

# Start Docker desktop
echo "Starting Docker Desktop..."
open -a Docker
# Wait for Docker to start
while ! docker info >/dev/null 2>&1; do
    echo "Waiting for Docker to start..."
    sleep 5
done
echo "Docker is running."
# Check if the container exists
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME already exists."
    echo "Starting Docker container ..."
    # Start the existing container
    docker start $CONTAINER_NAME

else
    # Check if the image exists
    if [ "$(docker images -q $CONTAINER_NAME:latest 2> /dev/null)" ]; then
        echo "Image $CONTAINER_NAME already exists."
    else
        # Build the Docker image
        echo "Building Docker image..."
        docker build -t $CONTAINER_NAME ../.
    fi
    # Create and start the Docker container
    echo "Creating and starting Docker container..."
    docker run -d --name $CONTAINER_NAME -p 8888:8888 $CONTAINER_NAME
fi
# Wait for the container to be ready
sleep 10
echo "Container is ready."

# Print http refference from container $CONTAINER_NAME logs started from http://127.0.0.1..... using sed 
docker logs $CONTAINER_NAME 2>&1 | grep -oE 'http://127\.0\.0\.1:8888/lab\?token=[a-f0-9]+' | tail -n 1

# Delete the environment variables
unset $(grep -oE '^[^=]+' *.env | xargs)


### Change current settings vscode Jupyter server URL to the one from the logs
##echo "Changing Jupyter server URL in VSCode settings..."
### TOKEN=$(docker logs $CONTAINER_NAME 2>&1 | grep -oE 'http://127\.0\.0\.1:8888/tree\?token=[a-f0-9]+' | tail -n 1 | grep -oE '[a-f0-9]+' | tail -n 1)
### Get the current settings file path
##settings_file="$HOME/Library/Application Support/Code/User/settings.json"
### Check if the settings file exists
##if [ -f "$settings_file" ]; then
##    # Use sed to define Jupyter server URL in the settings file
##    sed -i '' "s#\(\"jupyter\.serverURI\": \"http://[^?]*?token=\)[^\"]*#\1$TOKEN#" "$settings_file"
##    echo "Jupyter server URL changed in VSCode settings."
##else
##    echo "Settings file not found: $settings_file"
##fi
### Reload VSCode
##echo "Reloading VSCode..."
##code -r
##
