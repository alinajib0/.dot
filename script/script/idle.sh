#!/bin/bash

IDLE_TIMEOUT=$((20 * 60))

while true; do
  IDLE_MS=$(xprintidle)
  IDLE_SEC=$((IDLE_MS / 1000))

  if [ "$IDLE_SEC" -ge "$IDLE_TIMEOUT" ]; then
    echo "System inactive for $IDLE_SEC seconds. Suspending..."
    slock
    sleep 10
  else
    sleep 120
  fi
done
