#!/bin/bash

WALL_DIR="$HOME/Pictures/wallpapers"

themes=$(find "$WALL_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
choice=$(echo -e "$themes" | rofi -dmenu -i -p "🎨 Тема" -theme ~/.config/rofi/style.rasi)

if [[ -n "$choice" ]]; then
    random_wall=$(find "$WALL_DIR/$choice" -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg -o -iname \*.gif \) | shuf -n 1)
    
    if [[ -n "$random_wall" ]]; then
        wal -q -n -i "$random_wall"
        killall swaybg
        swaybg -i "$random_wall" -m fill &
        killall waybar
        sleep 0.5
        waybar &
        notify-send -t 2000 "✨ Тему оновлено!" "Вибрано вайб: $choice"
    fi
fi
