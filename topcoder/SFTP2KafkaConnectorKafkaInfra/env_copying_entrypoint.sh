#!/bin/bash

set -e

# Allow the container to be started with `--user`
if [[ "$1" = 'bin/kafka-server-start.sh' && "$(id -u)" = '0' ]]; then
    chown -R "$KAFKA_USER" "$KAFKA_LOG_DIR" "$KAFKA_CONF_DIR"
    echo "$0" "$@"
    exec su-exec "$KAFKA_USER" "$0" "$@"
fi

# Generate the config only if it doesn't exist
if [[ -f "$KAFKA_CONF_DIR/kafka-server.properties" ]]; then

    CONFIG="$KAFKA_CONF_DIR/kafka-server.properties"
    echo "$CONFIG"
    echo "broker.id=$KAFKA_BROKER_ID" >> "$CONFIG"
    echo "zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT" >> "$CONFIG"
    echo "log.dirs=$KAFKA_LOG_DIR" >> "$CONFIG"

    chmod 777 -Rf "$KAFKA_CONF_DIR"/*
fi

exec "$@"
