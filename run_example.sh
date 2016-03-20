#!/bin/bash

# LOGSTASH-TESTER RUNNER
# 1. Copy this file and edit the configuration.
# 2. Edit the config below
# 3. Run "./run.sh" to execute pattern and filter tests, "./run.sh filter" to
#    execute only the filter tests, "./run.sh patterns" to only test patterns.


# CONFIGURATION #######################
LST='.'                       # Location of Logstash-Tester files

FILTER_CONFIG='example/config/conf.d'   # Logstash configuration and patterns you want to test
PATTERN='example/config/patterns'

FILTER_TESTS='example/test/filters'     # Test case files
PATTERN_TESTS='example/test/patterns'
# END CONFIGURATION ###################


set -e

echo "====> Build docker image for test"
docker build -t gaspaio/logstash-tester \
  --build-arg LST=$LST \
  --build-arg FILTER_CONFIG=$FILTER_CONFIG \
  --build-arg PATTERN=$PATTERN \
  --build-arg FILTER_TESTS=$FILTER_TESTS \
  --build-arg PATTERN_TESTS=$PATTERN_TESTS \
  -f $LST/Dockerfile .

# echo "====> Run test in docker container"
docker run --rm -it gaspaio/logstash-tester $1

