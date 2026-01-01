#!/usr/bin/env bash

# Check if any KDE Connect device is connected
if kdeconnect-cli -a --id-only 2>/dev/null | grep -q .; then
    echo ""
else
    echo ""
fi
