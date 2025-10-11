#!/bin/bash

IDLE_TIMEOUT=$((20 * 60))

while true; do
  IDLE_MS=$(xprintidle)
  IDLE_SEC=$((IDLE_MS / 1000))

  if [ "$IDLE_SEC" -ge "$IDLE_TIMEOUT" ]; then
    notify-send "System inactive for $IDLE_SEC seconds. after 10 seconds the system will suspend."
    sleep 10
    # Double check idle time before suspending
    IDLE_MS=$(xprintidle)
    IDLE_SEC=$((IDLE_MS / 1000))
    if [ "$IDLE_SEC" -lt "$IDLE_TIMEOUT" ]; then
      continue
    fi
    nologin "System is suspending due to inactivity."
    # Use systemctl to suspend
    systemctl suspend && slock
    sleep 10
  else
    sleep 120
  fi
done
