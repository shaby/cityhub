#!/bin/sh
docker-compose down

sudo mv -rf ./logs ./logs_$(date +%Y%m%d%H%M)
mkdir logs

