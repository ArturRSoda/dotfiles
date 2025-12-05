#!/bin/bash

# 1. TOGGLE CHECK
# If Rofi is already running, kill it and exit.
# This fixes the "Already running" error and allows you to close the menu by clicking the button again.
if pgrep -x "rofi" >/dev/null; then
    pkill -x rofi
    exit 0
fi

# 2. Define the options
shutdown=" Shutdown"
reboot=" Reboot"
lock=" Lock"
suspend=" Suspend"
logout=" Logout"

# 3. Pipe them into Rofi
chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -p "Power" -theme ~/.config/rofi/power.rasi)
#chosen=$(echo -e "$logout\n$reboot\n$shutdown" | rofi -dmenu -p "Power" -theme ~/.config/rofi/power.rasi)

# 4. Handle the choice
case "$chosen" in
"$lock")
    hyprlock
    ;;
"$suspend")
    systemctl suspend
    ;;
"$logout")
    hyprctl dispatch exit
    ;;
"$reboot")
    systemctl reboot
    ;;
"$shutdown")
    systemctl poweroff
    ;;
esac
