#!/bin/bash

TEST_DIR="/volume1/homes"
DOCKER_DIR="/volume1/docker"

if [ -d "$TEST_DIR" ]; then
	YML_LIST=$(cat /volume1/docker/docker-compose.yml|grep "container_name"|awk '$2 != "container_name:" {print $2}'|sort);
	RUNNING_LIST=$(docker ps | awk '$NF != "NAMES" {print $NF}'|sort);
	if [ "$YML_LIST" != "$RUNNING_LIST" ]; then
		docker-compose -f $DOCKER_DIR/docker-compose.yml up -d --remove-orphans
	fi
fi
