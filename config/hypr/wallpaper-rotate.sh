#!/bin/sh
# Rotates the wallpaper randomly from /usr/share/backgrounds every INTERVAL seconds.

WALLPAPER_DIR="/usr/share/backgrounds"
INTERVAL=1800  # 30 minutes

set_random_wallpaper() {
    img=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | shuf -n 1)
    [ -n "$img" ] || return
    pkill -x swaybg 2>/dev/null
    swaybg -i "$img" -m fill &
}

while true; do
    set_random_wallpaper
    sleep "$INTERVAL"
done
