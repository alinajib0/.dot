STEP_PERCENT=5
SINK=$(pactl get-default-sink)

case $1 in
    up) pactl set-sink-volume $SINK +${STEP_PERCENT}% ;;
    down) pactl set-sink-volume $SINK -${STEP_PERCENT}% ;;
    toggle) pactl set-sink-mute $SINK toggle ;;
esac

VOLUME=$(pamixer --get-volume)
MUTE=$(pamixer --get-mute)

if [ "$MUTE" = "true" ]; then
    notify-send "Volume" "Muted-$VOLUME" 
else
    notify-send "Volume" "Set to $VOLUME"
fi
