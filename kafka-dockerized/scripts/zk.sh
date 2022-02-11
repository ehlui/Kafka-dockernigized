#!/bin/bash -e

# Purpose:
# Run a zookeeper instance in a docker container
# to enable each kafka cluster join and create topics
# Args (both optionals):
# 1- container name
# 2- image name

IMAGE_NAME=hikager/zookeeper:2.8.1
CONTAINER_NAME=zookeeper-1

if [ -n "$1"  ] ; then CONTAINER_NAME=$1; fi
if [ -n "$2"  ] ; then IMAGE_NAME=$2; fi

is_zookeeper(){
  CID="$(docker ps -q -f status=running -f name=^/"${CONTAINER_NAME}"$)"
  if [ ! "${CID}" ]; then echo 1 ;return; fi
  echo 0
}

run_zookeeper(){
  # shellcheck disable=SC2155
  local is_zk_container="$(is_zookeeper)"
  if [[ "$is_zk_container" == 1 ]]; then
    docker run -d --rm \
        --name "$CONTAINER_NAME" \
        --net kafka-net \
        -v "${PWD}"/config/zookeeper-1/zookeeper.properties:/kafka/config/zookeeper.properties \
        "$IMAGE_NAME"
  fi
}

run_zookeeper
