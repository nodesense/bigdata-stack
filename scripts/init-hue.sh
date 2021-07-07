#!/bin/bash
cd "${0%/*}"
docker run -it --rm --network="host" --env-file ../config/hadoop-hive.env -v /:/host johannestang/hadoop-base:2.0.0-hadoop2.8.5-java8 hdfs dfs -mkdir -p /user/admin
