#!/bin/bash

exec /opt/flume/bin/flume-ng agent -n ${AGENT_NAME} -f ${AGENT_FILE} -c ${AGENT_CONF} -Dflume.root.logger=INFO,console

