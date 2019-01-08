#!/bin/bash


IP=$(grep "\s${HOSTNAME}$" /etc/hosts | head -n 1 | awk '{print $1}')


cat /opt/kafka/config/server.properties.template | sed \
  -e "s|{{KAFKA_LISTENERS}}|${KAFKA_LISTENERS:-PLAINTEXT://${IP}:9092}|g" \
  -e "s|{{KAFKA_ADVERTISED_LISTENERS}}|${KAFKA_ADVERTISED_LISTENERS:-PLAINTEXT://${IP}:9092}|g" \
  -e "s|{{KAFKA_BROKER_ID}}|${KAFKA_BROKER_ID:-0}|g" \
  -e "s|{{KAFKA_NUM_PARTITIONS}}|${KAFKA_NUM_PARTITIONS:-1}|g" \
  -e "s|{{ZOOKEEPER_CONNECTION_STRING}}|${ZOOKEEPER_CONNECTION_STRING}|g" \
   > /opt/kafka/config/server.properties


while ! nc -z $WAIT_FOR_HOST $WAIT_FOR_PORT; do
  >&2 echo "$WAIT_FOR_HOST $WAIT_FOR_PORT - sleeping"
  sleep 1
done
>&2 echo "$WAIT_FOR_HOST $WAIT_FOR_PORT is up - Starting kafka"



exec bin/kafka-server-start.sh /opt/kafka/config/server.properties



