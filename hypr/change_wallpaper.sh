#!/bin/bash

# 1. Wait for system (only matters on startup)
sleep 1

# 2. Define Vars
DIR_MAIN="$HOME/Pictures/Wallpapers/Main"

# 3. Pick Random
WALL_MAIN=$(find "$DIR_MAIN" -type f | shuf -n 1)

if [ -z "$WALL_MAIN" ]; then
    exit 1
fi

# 4. Generate Colors (This updates ~/.cache/wal/colors-hyprland.conf)
/home/artur/.local/bin/wal -i "$WALL_MAIN" -n >/dev/null 2>&1

# 5. Set Wallpaper
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$WALL_MAIN"
#hyprctl hyprpaper wallpaper "DP-3,$WALL_MAIN"
#hyprctl hyprpaper wallpaper "HDMI-A-1,$WALL_MAIN"
for monitor in $(hyprctl monitors | grep "Monitor" | awk '{print $2}'); do
    hyprctl hyprpaper wallpaper "$monitor,$WALL_MAIN"
done

# 1. Reload Hyprland (Refreshes borders)
hyprctl reload

# 2. Reload Waybar (Refreshes top bar)
pkill waybar
sleep 0.1 # Safety buffer
waybar &

# 3. Reload Dunst (Refreshes notifications)
# We kill it and restart it so it reads the new Pywal config
pkill dunst
dunst &

# 4. Reload SwayOSD (Refreshes volume UI)
# We must explicitly point to the config style we set up
pkill swayosd-server
swayosd-server --style ~/.config/swayosd/style.css &
