#!/usr/bin/env bash

SESSION_NAME="tmux"
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  # Wenn die Sitzung nicht existiert, lösche das erste pane und starte eine neue tmux-sesstion
  alacritty -T main-session -e tmux new-session -A -D -s "$SESSION_NAME" -n "main" "~/.config/ranger/ranger_cd.sh"

else

  if ! hyprctl activewindow -j | jq -r '.title' | grep -q "main-session"; then
    alacritty -T main-session -e tmux new-session -A -D -s "$SESSION_NAME" \; split-window "~/.config/ranger/ranger_cd.sh"

  else
    tmux split-window -t "$SESSION_NAME":1 "~/.config/ranger/ranger_cd.sh"
  fi
fi
