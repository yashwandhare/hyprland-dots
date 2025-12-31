#!/bin/bash
brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((brightness * 100 / max))
notify-send -t 1000 -h string:x-canonical-private-synchronous:brightness "Brightness: ${percent}%" -h int:value:$percent
