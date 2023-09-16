#!/bin/bash

set -e

signal_handler() {
  echo "$(date +%F_%T) INFO: Received SIGNAL. Stopping batch process ..."
  for _ in $(seq 1 "$1"); do
    pid=$(pidof _progres)
    if [ -n "${pid}" ]; then
      echo "$(date +%F_%T) INFO: Batch PID found. PID: ${pid}"
    fi
    sleep 1
  done
  kill ${pid}
  exit ${?}
}

trap 'signal_handler' SIGTERM SIGINT

export TERM=xterm

$DLC/bin/_progres -b -pf /app/batchRunner.pf

exit 1