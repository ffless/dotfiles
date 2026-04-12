#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/rofi-wallpapers"
mkdir -p "$CACHE_DIR"

# Генеруємо мініатюри
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
    [ -f "$img" ] || continue
    fname=$(basename "$img")
    thumb="$CACHE_DIR/${fname}.png"
    if [ ! -f "$thumb" ]; then
        magick "$img" -thumbnail 300x200^ -gravity center -extent 300x200 "$thumb" 2>/dev/null
    fi
done

# Формуємо список для rofi
entries=""
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
    [ -f "$img" ] || continue
    fname=$(basename "$img")
    thumb="$CACHE_DIR/${fname}.png"
    entries+="${fname}\0icon\x1f${thumb}\n"
done

# Показуємо rofi
chosen=$(printf "%b" "$entries" | rofi -dmenu \
    -p "Шпалери" \
    -show-icons \
    -theme-str 'element-icon { size: 10em; border-radius: 6px; }' \
    -theme-str 'listview { columns: 3; lines: 3; }' \
    -theme-str 'element { orientation: vertical; }' \
    -theme-str 'element-text { horizontal-align: 0.5; }')

[ -z "$chosen" ] && exit

# Встановлюємо з pywal + swaybg + waybar
wal -i "$WALLPAPER_DIR/$chosen"
pkill swaybg; swaybg -i "$WALLPAPER_DIR/$chosen" -m fill &
pkill waybar; waybar > /dev/null 2>&1 &
