#!/bin/sh

xrandr --output VGA-0 --scale 1.2 --gamma 1.0:1.0:1.0
setxkbmap -layout us,ara -variant ,digits -option altwin:swap_alt_win grp:alt_caps_toggle caps:escape

dunst &
dwmblocks &
sxhkd &
clipmenud &

alacritty -e termdown 2025-12-31 &

while true; do
  # Log stderror to a file
  dwm 2>~/.dwm.log
  # No error logging
  #dwm >/dev/null 2>&1
done
