#!/bin/bash

while ! nc -z $WAIT_FOR_HOST $WAIT_FOR_PORT; do
 >&2 echo "$WAIT_FOR_HOST $WAIT_FOR_PORT - sleeping"
 sleep 1
done
>&2 echo "$WAIT_FOR_HOST $WAIT_FOR_PORT is up - Starting flume"

exec /opt/flume/bin/flume-ng agent -n ${AGENT_NAME} -f ${AGENT_FILE} -c ${AGENT_CONF} -Dflume.root.logger=INFO,DAILY

