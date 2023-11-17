#!/usr/bin/env bash

TEST=$(docker run -it --rm --name prom-conf-test --mount type=bind,source=`pwd`/prometheus.yml,target=/prometheus/prometheus.yml --entrypoint="" prom/prometheus:latest /bin/promtool check config /prometheus/prometheus.yml | grep SUCCESS)

if [ $? -eq 0 ];
then
	echo "promtool check config: SUCCESS"
else
	echo "promtool check config: FAILED"
	exit 1
fi

docker compose down
docker compose up --build --remove-orphans -d
