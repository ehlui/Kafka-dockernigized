#!/bin/bash -e

# Purpose:
# - Run our build scripts for our docker images
# We need to pass an argument which will be
# the image tag

kafka_img_tag=hikager/kafka:2.8.1
zk_img_tag=hikager/zookeeper:2.8.1

# Cleaning images for being rebuild later
docker rmi -f "$kafka_img_tag" "$zk_img_tag"

echo "Building our kafka docker-image"
cd kafka/ && bash build "$kafka_img_tag"

cd ..

echo "Building our zookeeper docker-image"
cd zookeeper/ && bash build "$zk_img_tag"
