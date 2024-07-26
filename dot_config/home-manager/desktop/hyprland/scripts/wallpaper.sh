#!/usr/bin/env bash

# Path to your wallpapers folder
WALLPAPER_DIR="~/Pictures/Hintergrund Bilder/nordic-wallpapers"

# Get a random wallpaper from the folder
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Set the wallpaper using swaybg
swaybg -i "$WALLPAPER" -m fill
