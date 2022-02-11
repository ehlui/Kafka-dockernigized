#!/bin/bash -e

# Purpose:
# Remove all files and directories (including hidden files)
# From our kafka logs and apps

rm -r ./data/kafka-1/{*,.*}
rm -r ./data/kafka-2/{*,.*}
rm -r ./data/kafka-producer-1/{*,.*}
rm -r ./data/zookeeper-1/{*,.*}