#!/bin/bash

# Stop any previous instances
echo "Stopping previous the-feed containers..."
docker stop the-feed

# Remove the old container to avoid conflicts
docker rm the-feed

# Pull the docker image
echo "Downloading docker image..."
docker pull mechlizard/the-feed-web:latest

# Create a container from the image
echo "Creating container..."
docker create -p 3000:3000 --name the-feed mechlizard/the-feed-web:latest

# Copy files from the current directory to the container
echo "Copying project files..."
docker cp ./MERN the-feed:/home/circleci/project/MERN
docker cp ./public the-feed:/home/circleci/project/public
docker cp ./src the-feed:/home/circleci/project/src
docker cp ./test the-feed:/home/circleci/project/test
docker cp ./package.json the-feed:/home/circleci/project
docker cp ./package-lock.json the-feed:/home/circleci/project

# Start the container
echo "Starting the container..."
docker start the-feed

# Run the container and follow logs
docker logs -f the-feed