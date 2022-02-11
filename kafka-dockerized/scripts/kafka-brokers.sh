#!/bin/bash -e

# Purpose:
# Run a kafka cluster in a docker container
# joining to a zookeeper cluster already running
# Args (both optionals):
# 1- container name
# 2- image name

IMAGE_NAME=hikager/kafka:2.8.1
CONTAINER_NAME=kafka-1
KAFKA_PROPERTIES=server.properties

if [ -n "$1"  ] ; then CONTAINER_NAME=$1; fi
if [ -n "$2"  ] ; then IMAGE_NAME=$2; fi


is_kafka_broker(){
  CID="$(docker ps -q -f status=running -f name=^/"${CONTAINER_NAME}"$)"
  if [ ! "${CID}" ]; then echo 1 ;return; fi
  echo 0
}

run_broker(){
  # shellcheck disable=SC2155
  local is_kafka_container="$(is_kafka_broker)"
  if [[ "$is_kafka_container" == 1 ]]; then
    docker run -d --rm \
        --name "$CONTAINER_NAME" \
        --net kafka-net \
        -v "${PWD}"/data/"$CONTAINER_NAME"/:/tmp/kafka-logs/ \
        -v "${PWD}"/config/"$CONTAINER_NAME"/$KAFKA_PROPERTIES:/kafka/config/$KAFKA_PROPERTIES  \
        "$IMAGE_NAME"
  fi
}

run_broker
