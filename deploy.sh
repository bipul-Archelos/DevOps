#!/bin/bash

echo "Stopping old container..."
docker stop devops-app-container || true
docker rm devops-app-container || true

echo "Pulling latest image..."
docker pull testethical/devops-app:v1

echo "Starting new container..."
docker run -d -p 5000:5000 --name devops-app-container testethical/devops-app:v1

echo "Backend deployment DONE!"