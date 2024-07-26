#!/usr/bin/env bash

status_file="/tmp/waybar_fullscreen_status"
current_status=""

# Create the status file if it doesn't exist
touch $status_file

while true; do
    # Get the active window's details
    window_fullscreen=$(hyprctl activewindow -j | jq -r '.fullscreen')

    if [[ $window_fullscreen == "true" ]]; then
        new_status='{"text": "󰊓", "alt": "fullscreen"}'
    else
        new_status='{"text": "󰊔", "alt": "not-fullscreen"}'
    fi

    # Update the status file only if the status has changed
    if [[ "$new_status" != "$current_status" ]]; then
        echo $new_status > $status_file
        current_status=$new_status
    fi

    sleep 1
done

