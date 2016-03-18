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
  rspec -f p /test/spec/patterns_spec.rb
fi

if $CONF ; then
  echo "###  TEST FILTERS SYNTAX  ####################"
  logstash --configtest -f /etc/logstash/conf.d

  echo "###  RUN FILTER TESTS     ##################"
  rspec -f p /test/spec/filter_spec.rb
fi

