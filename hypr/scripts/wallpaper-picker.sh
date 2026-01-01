#!/usr/bin/env bash

# =========================
# Configuration
# =========================
WALLDIR="${WALLPAPER_DIR:-$HOME/Downloads/walls}"
CACHE="$HOME/.cache/wallpicker"
ROFI_THEME="${ROFI_WALLPAPER_THEME:-$HOME/.config/hypr/rofi/wallpaper.rasi}"
THUMBNAIL_SIZE=400
TRANSITION_TYPE="${SWWW_TRANSITION:-fade}"
TRANSITION_DURATION="${SWWW_DURATION:-0.8}"

# =========================
# Safety
# =========================
set -euo pipefail

# =========================
# Dependency check
# =========================
check_dependencies() {
    local deps=(rofi swww magick find)
    local missing=()

    for d in "${deps[@]}"; do
        command -v "$d" &>/dev/null || missing+=("$d")
    done

    if [ "${#missing[@]}" -gt 0 ]; then
        echo "Missing dependencies: ${missing[*]}"
        exit 1
    fi
}

# =========================
# swww daemon
# =========================
check_swww_daemon() {
    if ! pgrep -x swww-daemon >/dev/null; then
        swww-daemon &
        sleep 1
    fi
}

# =========================
# Thumbnails
# =========================
generate_thumbnails() {
    mkdir -p "$CACHE"

    find "$WALLDIR" -type f \( \
        -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \
    \) | sort | while read -r img; do
        thumb="$CACHE/$(basename "$img")"
        if [ ! -f "$thumb" ] || [ "$img" -nt "$thumb" ]; then
            magick "$img" \
                -resize "${THUMBNAIL_SIZE}x${THUMBNAIL_SIZE}^" \
                -gravity center \
                -extent "${THUMBNAIL_SIZE}x${THUMBNAIL_SIZE}" \
                -quality 85 \
                "$thumb"
        fi
    done
}

# =========================
# Rofi picker
# =========================
launch_picker() {
    for img in "$CACHE"/*; do
        [ -f "$img" ] || continue
        printf "%s\0icon\x1f%s\n" "$(basename "$img")" "$img"
    done | rofi -dmenu \
        -theme "$ROFI_THEME" \
        -p "🖼️  Wallpaper" \
        -matching fuzzy \
        -no-custom
}

# =========================
# Apply wallpaper
# =========================
apply_wallpaper() {
    local selected="$1"
    local file="$WALLDIR/$selected"

    [ -f "$file" ] || exit 0

    swww img "$file" \
        --transition-type "$TRANSITION_TYPE" \
        --transition-duration "$TRANSITION_DURATION" \
        --transition-fps 60

    echo "$file" > "$HOME/.cache/current_wallpaper"
}

# =========================
# Main
# =========================
check_dependencies
check_swww_daemon
generate_thumbnails

selected="$(launch_picker)"
[ -z "$selected" ] && exit 0

apply_wallpaper "$selected"
