#!/bin/bash

options="lock Screen\nlogout\nsuspend\nreboot\npoweroff"
choice=$(echo -e "$options" | dmenu)

case "$choice" in
    "lock Screen")
        slock
        ;;
    "logout")
        pkill -u "$USER"
        ;;
    "suspend")
        doas zzz
        ;;
    "reboot")
        doas reboot
        ;;
    "poweroff")
        doas poweroff
        ;;
esac
