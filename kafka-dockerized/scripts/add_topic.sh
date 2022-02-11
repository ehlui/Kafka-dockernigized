#!/bin/bash -e

CONTAINER_NAME=zookeeper-1
TOPIC_NAME=test2

add_topic(){
  echo "Trying to create a topic to our cluster..."
  docker exec -it zookeeper-1 bash -c "/kafka/bin/kafka-topics.sh --create --partitions 1 --replication-factor 1 --topic $TOPIC_NAME --zookeeper $CONTAINER_NAME:2181"
}

add_topic
