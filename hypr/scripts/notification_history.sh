#!/bin/bash

# 1. Get History
# 2. jq magic:
#    - gsub("\n"; " "): Replaces 'Enter' keys in messages with spaces so it stays on one line
#    - <b>...</b>: Bolds the App Name
#    - span alpha: Dims the message body so the title stands out
# 3. rofi -markup-rows: Tells Rofi to read the html tags

dunstctl history | jq -r '.data[0][] | "<b>\(.appname.data)</b>: \(.summary.data) <span alpha=\"70%\">\(.body.data | gsub("\\n"; " ") | gsub("\\t"; " "))</span>"' | \
rofi -dmenu \
    -markup-rows \
    -theme ~/.config/rofi/launcher.rasi \
    -p " " \
    -theme-str 'listview { lines: 10; }' \
    -theme-str 'window { width: 900px; }' \
    -theme-str 'configuration { show-icons: false; }'
