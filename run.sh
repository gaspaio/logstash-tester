#!/bin/bash
set -e

echo "====> Build docker image for test"
docker build -t gaspaio/logstash-tester .

echo "====> Run test in docker container"
docker run --rm -it gaspaio/logstash-tester $1

