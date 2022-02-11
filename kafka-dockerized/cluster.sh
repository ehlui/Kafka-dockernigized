#!/bin/bash -e

# Purpose:
# Centralize the running of our main scripts
# to build and run each container we need
# to run a kafka cluster in our local-host

# Args (optional)
# 1- rm
#   -It force to remove the containers we're going to use

if [ -n "$1" ] && [ "$1" == "rm" ] ; then
  docker rm -f zookeeper-1 kafka-1 service-producer-1
fi

chmod -R +x  ./scripts

./scripts/clean_data.sh
./scripts/build.sh
./scripts/zk.sh
# Wait for ZK to setup itself
sleep 5
./scripts/kafka-brokers.sh
# Wait for the broker to setup
sleep 2
./scripts/producer.sh
# Let's see if all 3 are running
docker ps