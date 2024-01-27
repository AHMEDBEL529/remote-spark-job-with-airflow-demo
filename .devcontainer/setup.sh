#!/bin/bash

# Install Astronomer CLI
curl -sSL install.astronomer.io | sudo bash -s

# Create Spark app directory
mkdir -p ./spark/app

# Wait for Docker daemon to be ready
sleep 20

# Start the Astronomer development environment
astro dev start -n --wait 8m

# Build custom Spark image
docker build -t custom-spark -f Dockerfile-spark .

# Get the Airflow network name
export AIRFLOW_NETWORK=$(docker network ls --filter "name=.*airflow" --format "{{.Name}}")

# Update Docker Compose file with Airflow network
sed -i "s/AIRFLOW_NETWORK/$AIRFLOW_NETWORK/g" ./docker-compose-spark.yml

# Start Spark cluster with Docker Compose
docker-compose -f docker-compose-spark.yml up -d
