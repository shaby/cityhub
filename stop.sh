#!/bin/sh
docker-compose down

sudo cp -rf ./logs ./logs_$(date +%Y%m%d%H%M)
sudo rm -rf ./logs
mkdir logs

