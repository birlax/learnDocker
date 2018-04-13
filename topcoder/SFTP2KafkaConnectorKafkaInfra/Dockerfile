FROM openjdk:8-jre-alpine

# Install required packages
RUN apk add --no-cache \
    bash \
    su-exec

ENV KAFKA_USER=kafka \
    KAFKA_BASE_DIR=/var/opt/lib/kafka \
    KAFKA_PORT=9092 \
    KAFKA_BROKER_ID=1 \
    KAFKA_ZOOKEEPER_CONNECT=172.18.0.1:2181,172.18.0.2:2181,172.18.0.3:2181

ENV KAFKA_LOG_DIR=$KAFKA_BASE_DIR/logs/ \
    KAFKA_CONF_DIR=$KAFKA_BASE_DIR/config/

# Add a user and make dirs
RUN set -ex; \
    adduser -D "$KAFKA_USER"; \
    mkdir -p "$KAFKA_BASE_DIR" "$KAFKA_LOG_DIR" "$KAFKA_CONF_DIR"; \
    chown "$KAFKA_USER:$KAFKA_USER" "$KAFKA_BASE_DIR" "$KAFKA_LOG_DIR" "$KAFKA_CONF_DIR"

ADD . "$KAFKA_BASE_DIR"

WORKDIR "$KAFKA_BASE_DIR"

RUN tar -xf kafka_2.12-1.1.0.tgz -C "$KAFKA_BASE_DIR"

RUN cp env_copying_entrypoint.sh kafka_2.12-1.1.0/bin/
RUN cp default-kafka-server.properties "$KAFKA_CONF_DIR"/kafka-server.properties
RUN cp default-log4j.properties "$KAFKA_CONF_DIR"/log4j.properties

WORKDIR "$KAFKA_BASE_DIR"/kafka_2.12-1.1.0/

RUN chmod +x bin/*.sh
RUN chmod +rw "$KAFKA_CONF_DIR"/*

VOLUME ["$KAFKA_LOG_DIR"]

EXPOSE $KAFKA_PORT

ENV PATH=$PATH:"$KAFKA_BASE_DIR"/kafka_2.12-1.1.0/bin

ENV KAFKA_CONF_DIR=$KAFKA_CONF_DIR

ENTRYPOINT ["bin/env_copying_entrypoint.sh"]

CMD ["bin/kafka-server-start.sh", "../config/kafka-server.properties"]
