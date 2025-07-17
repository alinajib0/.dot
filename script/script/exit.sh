#!/bin/bash

options="Lock Screen\nLogout\nSuspend\nReboot\nPoweroff"
choice=$(echo -e "$options" | dmenu)

case "$choice" in
    "Lock Screen")
        slock
        ;;
    "Logout")
        pkill -u "$USER"
        ;;
    "Suspend")
        systemctl suspend && slock
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Poweroff")
        systemctl poweroff
        ;;
esac
