#!/usr/bin/env bash

# Check if the command is empty
if [[ -z "$var" ]]; then
    # Set the command to nothing (dot)
    command="zsh"
fi

SESSION_NAME="tmux"
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  # Wenn die Sitzung nicht existiert, lösche das erste pane und starte eine neue tmux-sesstion
  alacritty -T main-session -e tmux new-session -ADs "$SESSION_NAME" -n "main" "$@"
else
  if ! hyprctl activewindow -j | jq -r '.title' | grep "main-session"; then
    alacritty -T main-session -e tmux new-session -ADs "$SESSION_NAME" \; split-window "$@"
  else
    tmux split-window -t "$SESSION_NAME":1 "$@"
  fi
fi
