#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CURRENT_FILE="$HOME/.cache/current_wallpaper"

mapfile -t walls < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | sort)
[ ${#walls[@]} -eq 0 ] && exit 1

current=$(cat "$CURRENT_FILE" 2>/dev/null)
next_idx=0
for i in "${!walls[@]}"; do
    if [[ "${walls[$i]}" == "$current" ]]; then
        next_idx=$(( (i + 1) % ${#walls[@]} ))
        break
    fi
done

next="${walls[$next_idx]}"
echo "$next" > "$CURRENT_FILE"

wal -i "$next"
pkill swaybg; swaybg -i "$next" -m fill &
pkill waybar; waybar > /dev/null 2>&1 &
