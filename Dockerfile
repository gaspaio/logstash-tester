FROM java:8-jre
ARG LOGSTASH_VERSION=2.2.0

# Install Logstash
RUN wget \
    https://download.elastic.co/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz \
    -O /tmp/logstash.tar.gz \
    && tar xfz /tmp/logstash.tar.gz -C /opt \
    && rm /tmp/logstash.tar.gz \
    && mv /opt/logstash-${LOGSTASH_VERSION} /opt/logstash

# Install plugin for development
RUN /opt/logstash/bin/plugin install --development

# Copy logstash config dir and tests
# Assumes the patterns_dir param in grok filters is /etc/logstash/patterns_dir
ADD config /etc/logstash
ADD test /test

ENTRYPOINT ["/test/run-tests.sh"]

