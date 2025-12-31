#!/bin/bash
volume=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

if [ "$muted" = "true" ]; then
    notify-send -t 1000 -h string:x-canonical-private-synchronous:volume "Volume: MUTED" -h int:value:0
else
    notify-send -t 1000 -h string:x-canonical-private-synchronous:volume "Volume: ${volume}%" -h int:value:$volume
fi
