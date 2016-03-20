FROM logstash:2.2.2

RUN plugin install --development

ARG LST
ARG FILTER_CONFIG
ARG PATTERN
ARG FILTER_TESTS
ARG PATTERN_TESTS

ADD $PATTERN /etc/logstash/patterns
ADD $LST/test /test
ADD $FILTER_CONFIG /test/spec/filter_config
ADD $FILTER_TESTS /test/spec/filter_data
ADD $PATTERN_TESTS /test/spec/pattern_data

ENTRYPOINT ["/test/run-tests.sh"]
# ENTRYPOINT ["bash"]
