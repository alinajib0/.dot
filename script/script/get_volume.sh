#!/bin/bash

# Get volume status and mute state
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2)
mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f3)

# Display with Nerd Font icons
if [ "$mute" = "[MUTED]" ]; then
    echo "󰖁 Muted"
else
    # Check if volume is numeric for comparison
    if [[ "$volume" =~ ^[0-9]+$ ]]; then
        if [ "$volume" -eq 0 ]; then
            echo "󰕿 ${volume}%"
        elif [ "$volume" -le 50 ]; then
            echo "󰖀 ${volume}%"
        else
            echo "󰕾 ${volume}%"
        fi
    else
        echo "󰖀 ${volume}"
    fi
fi
