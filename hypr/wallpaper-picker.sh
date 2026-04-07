#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

SELECTED=$(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" \) | while read -r file; do
    echo -en "$file\0icon\x1f$file\n"
done | rofi -dmenu -show-icons -i -p "Шпалери" -theme-str '
window { width: 800px; }
listview { columns: 4; lines: 3; }
element-icon { size: 150px; }
element-text { enabled: false; }
')

if [ -n "$SELECTED" ]; then
    wal -i "$SELECTED"
    killall swaybg
    swaybg -i "$SELECTED" -m fill &
    killall waybar
    sleep 0.5
    waybar &
fi
