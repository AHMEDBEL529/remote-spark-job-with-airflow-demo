#!/bin/bash
mkdir -p /workspaces/remote-spark-job-with-airflow-demo/spark/app

# Wait for Docker daemon to be ready
sleep 20

# Start the Astronomer development environment
astro dev start -n --wait 8m

docker build -t custom-spark -f Dockerfile-spark .
export AIRFLOW_NETWORK=$(docker network ls --filter "name=.*airflow" --format "{{.Name}}")
sed -i "s/AIRFLOW_NETWORK/$AIRFLOW_NETWORK/g" /workspaces/remote-spark-job-with-airflow-demo/docker-compose-spark.yml
docker-compose -f docker-compose-spark.yml up -d

