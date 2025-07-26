#!/bin/sh

xrandr --output VGA-0 --scale 1.35
feh --bg-fill ~/photo/wallpaper/3.png
setxkbmap -layout us,ara -variant ,digits -option altwin:swap_alt_win -option grp:alt_caps_toggle caps:escape

picom &
dunst &
slstatus &
sxhkd &
clipmenud &

while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
