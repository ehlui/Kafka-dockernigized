#!/bin/bash -e

PROPERTIES_FILE=server.properties
CONTAINER_NAME=kafka-1

is_kafka_broker(){
  CID="$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME}$)"
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
        -v "${PWD}"/config/$CONTAINER_NAME/$PROPERTIES_FILE:/kafka/config/$PROPERTIES_FILE \
        hikager/zookeeper:2.8.1
  fi
}


run_broker
