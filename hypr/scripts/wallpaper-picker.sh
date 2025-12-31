#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Downloads/walls"

# Collect wallpapers (absolute paths, stable)
WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \
\) 2>/dev/null)

[ -z "$WALLPAPERS" ] && exit 1

# Picker (no daemon logic, no height hacks)
SELECTED=$(printf "%s\n" "$WALLPAPERS" | wofi \
  --show dmenu \
  --width 700 \
  --lines 10 \
  --prompt "Wallpaper")

[ -z "$SELECTED" ] && exit 0

# Apply wallpaper (fast, clean transition)
swww img "$SELECTED" \
  --transition-type fade \
  --transition-duration 0.25
