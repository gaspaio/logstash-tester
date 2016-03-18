FROM logstash:latest

RUN plugin install --development

ADD config /etc/logstash
ADD test /test

ENTRYPOINT ["/test/run-tests.sh"]

