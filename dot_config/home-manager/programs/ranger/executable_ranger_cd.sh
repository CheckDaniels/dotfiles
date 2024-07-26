#!/usr/bin/env bash

temp_file=$(mktemp)
ranger --choosedir="$temp_file" "${@:-$PWD}"
if [ -f "$temp_file" ]; then
    chosen_dir=$(cat "$temp_file")
    rm -f "$temp_file"
    if [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
	cd "$chosen_dir"
    fi
fi

zsh
