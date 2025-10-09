#!/bin/bash

choice=$(printf "poweroff\nreboot\nsuspend\nlogout\nlock Screen" | rofi -dmenu -i)

case "$choice" in
    "poweroff")
        poweroff
        ;;
    "reboot")
        reboot
        ;;
    "suspend")
        systemctl suspend
        ;;
    "logout")
        pkill -u "$USER"
        ;;
    "lock Screen")
        slock
        ;;
esac
