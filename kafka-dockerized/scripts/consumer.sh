#!/bin/bash -e

# Purpose:
# Run a container
# Args (both optionals):
# 1- container name
# 2- image name

IMAGE_NAME=hikager/consumer-1:0.0.1
CONTAINER_NAME=service-consumer-1

if [ -n "$1"  ] ; then CONTAINER_NAME=$1; fi
if [ -n "$2"  ] ; then IMAGE_NAME=$2; fi


is_consumer_1(){
  CID="$(docker ps -q -f status=running -f name=^/"${CONTAINER_NAME}"$)"
  if [ ! "${CID}" ]; then echo 1 ;return; fi
  echo 0
}


run_consumer_1(){
  # shellcheck disable=SC2155
  local is_consumer_container="$(is_consumer_1)"
  if [[ "$is_consumer_container" == 1 ]]; then
    docker run --net kafka-net --name "$CONTAINER_NAME" -d -p 5900:8080 "$IMAGE_NAME"
  fi
}

run_consumer_1

