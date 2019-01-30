#!/bin/bash

if ! [ -z "$WAIT_FOR_HOST" ]; then
  while ! nc -z $WAIT_FOR_HOST $WAIT_FOR_PORT; do
   >&2 echo "$WAIT_FOR_HOST $WAIT_FOR_PORT - sleeping"
   sleep 1
  done
  >&2 echo "$WAIT_FOR_HOST $WAIT_FOR_PORT is up - Starting flume"
fi

exec /opt/flume/bin/flume-ng agent --name ${AGENT_NAME} --conf-file ${AGENT_FILE} --conf ${AGENT_CONF} -Dflume.root.logger=INFO,DAILY

