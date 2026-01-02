#!/usr/bin/env bash

STATE_FILE="/tmp/mic_indicator_state"

# 1. Check if any real (non-monitor) mic source is RUNNING
running_sources=$(pactl list sources short 2>/dev/null | \
    awk '$2 !~ /\.monitor$/ && $7 == "RUNNING"')

if [ -z "$running_sources" ]; then
    echo "inactive" > "$STATE_FILE" 2>/dev/null
    echo ""
    exit 0
fi

# 2. Get PIDs of apps recording from mic
pids=$(pactl list source-outputs 2>/dev/null | awk '
/^Source Output #/ {
    in_output=1
    pid=""
    source=""
}
/^\tSource:/ {
    if (in_output) source=$2
}
/^\tapplication.process.id = / {
    if (in_output) {
        gsub(/.* = /, "", $0)
        pid=$0
    }
}
/^[^ \t]/ && in_output {
    if (pid != "" && source !~ /\.monitor$/) {
        print pid
    }
    in_output=0
}
END {
    if (in_output && pid != "" && source !~ /\.monitor$/) {
        print pid
    }
}
' | sort -u)

# 3. Resolve PIDs → process names
apps=""
for pid in $pids; do
    if [ -r "/proc/$pid/comm" ]; then
        apps+="$(cat /proc/$pid/comm), "
    fi
done

apps=${apps%, }

# 4. Notify once per activation
if [ "$(cat "$STATE_FILE" 2>/dev/null)" != "active" ]; then
    if [ -n "$apps" ]; then
        notify-send -u low -t 2000 "Microphone" "󰍬 In use by: $apps"
    else
        notify-send -u low -t 2000 "Microphone" "󰍬 Microphone is active"
    fi
    echo "active" > "$STATE_FILE"
fi

# 5. Waybar output
if [ -n "$apps" ]; then
    echo "{\"text\":\"󰍬 MIC\",\"tooltip\":\"Using: $apps\"}"
else
    echo "{\"text\":\"󰍬 MIC\",\"tooltip\":\"Microphone Active\"}"
fi
