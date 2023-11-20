#!/bin/bash
mkdir -p ./spark/app

# Start the Astronomer development environment
astro dev start -n --wait 8m

docker build -t custom-spark -f Dockerfile-spark .
sed -i "s/AIRFLOW_NETWORK/$AIRFLOW_NETWORK/g" /workspaces/remote-spark-job-with-airflow-demo/docker-compose-spark.yml
docker-compose -f docker-compose-spark.yml up -d

