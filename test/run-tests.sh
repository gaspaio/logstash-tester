#!/bin/bash
set -e

PATS=true
CONF=true

case "$1" in
"filter")
  PATS=false
  ;;
"patterns")
  CONF=false
  ;;
esac

if $PATS ; then
  echo "###  RUN PATTERN TESTS    #####################"
  ./opt/logstash/bin/rspec -f p /test/spec/patterns
fi

if $CONF ; then
  echo "###  TEST FILTERS SYNTAX  ####################"
  ./opt/logstash/bin/logstash --configtest -f /etc/logstash/conf.d

  echo "###  RUN FILTER TESTS     ##################"
  ./opt/logstash/bin/rspec -f p /test/spec/conf.d
fi

