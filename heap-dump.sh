#!/bin/bash

if [ "$#" -eq 0 ]
then
  echo "./heap-dump.sh SECONDS NAME"
  echo "ARGS:"
  echo "     SECONDS is the time in seconds per-heap dump capture"
  echo "     NAME greppable name of the target application as reported by jps"
  echo "USAGE:"
  echo "     # The following will capture the heap every 60 seconds for an entry in jps like myapp-SNAPSHOT.jar"
  echo "     ./heap-dump 60 myapp"
  exit 1
fi

frequency_seconds=$1
jps_name=$2

pid=`jps | grep "$jps_name" | awk '{print $1}'`
echo "PID: $pid"

i=0

while true
do
  sleep "$frequency_seconds"
  jmap -dump:live,format=b,file="${pid}-${i}".bin "${pid}"
  ((i=i+1))
done
