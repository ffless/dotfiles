#!/bin/bash

# Використовуємо новий шлях до сокета через XDG_RUNTIME_DIR
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    if [[ $line == activelayout* ]]; then
        layout=$(echo "$line" | awk -F ',' '{print $2}')

        if [[ "$layout" == *"Ukrainian"* ]]; then
            lang="UA"
        elif [[ "$layout" == *"English"* ]]; then
            lang="EN"
        else
            lang="$layout"
        fi

            notify-send -a "lang_osd" -h string:x-dunst-stack-tag:lang -t 1000 "󰌌   $lang"
    fi
done
