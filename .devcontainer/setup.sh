#!/bin/bash
mkdir -p ./spark/app

# Start the Astronomer development environment
astro dev start -n --wait 8m
docker build -t custom-spark -f Dockerfile-spark .

docker-compose -f docker-compose-spark.yml up -d
