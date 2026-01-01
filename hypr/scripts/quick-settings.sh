#!/bin/bash

choice=$(printf "Wi-Fi\nBluetooth\nAudio\nBrightness\nPower\n" | wofi --dmenu --prompt "Quick Settings")

case "$choice" in
  "Wi-Fi")
    nm-connection-editor
    ;;
  "Bluetooth")
    blueman-manager
    ;;
  "Audio")
    pavucontrol
    ;;
  "Brightness")
    kitty -e brightnessctl
    ;;
  "Power")
    wlogout
    ;;
esac
