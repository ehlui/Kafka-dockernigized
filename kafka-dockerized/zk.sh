#!/bin/bash -e

CONTAINER_NAME=zookeeper-1
TOPIC_NAME=test2

is_zookeeper(){
  CID="$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME}$)"
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
        hikager/zookeeper:2.8.1
  fi
}

add_topic(){
  OUTPUT=$(docker exec -it $CONTAINER_NAME bash -c "/kafka/bin/kafka-topics.sh --list --zookeeper $CONTAINER_NAME:2181")
  if [  -n "$OUTPUT" ]
    then
      echo "Creating a topic to our cluster..."
      docker exec -it zookeeper-1 bash -c "/kafka/bin/kafka-topics.sh --create --partitions 1 --replication-factor 1 --topic $TOPIC_NAME --zookeeper $CONTAINER_NAME:2181"
    else
      echo -e "\nWe cannot create a topic :/"
    fi
}

run_zookeeper
add_topic

#/kafka/bin/kafka-topics.sh --create --partitions 1 --replication-factor 1 --topic test1 --zookeeper zookeeper-1:2181
