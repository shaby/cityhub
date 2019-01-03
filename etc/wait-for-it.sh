#!/bin/sh
# wait-for-it.sh

p1=$1
p2=$2
shift 3
cmd="$@"
# wait for the postgres docker to be running
while ! nc -z $p1 $p2; do
  >&2 echo "zookeeper is unavailable - sleeping"
  sleep 1
done

>&2 echo "zookeeper is up - executing command"
#exec $cmd