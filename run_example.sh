#!/bin/bash
echo "Running the example dir."
echo "Logstash config is stored at example/config, test cases at example/test"
./logstash-tester.sh -d example $@
