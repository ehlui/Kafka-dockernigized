#!/bin/bash -e

# Purpose:
# Run a container
# Args (both optionals):
# 1- container name
# 2- image name

IMAGE_NAME=hikager/producer-1:0.0.1
CONTAINER_NAME=service-producer-1

if [ -n "$1"  ] ; then CONTAINER_NAME=$1; fi
if [ -n "$2"  ] ; then IMAGE_NAME=$2; fi


is_producer_1(){
  CID="$(docker ps -q -f status=running -f name=^/"${CONTAINER_NAME}"$)"
  if [ ! "${CID}" ]; then echo 1 ;return; fi
  echo 0
}


run_producer_1(){
  # shellcheck disable=SC2155
  local is_producer_container="$(is_producer_1)"
  if [[ "$is_producer_container" == 1 ]]; then
    docker run --net kafka-net --name "$CONTAINER_NAME" -d -p 5001:5000 "$IMAGE_NAME"
  fi
}

run_producer_1

