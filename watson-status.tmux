#!/usr/bin/env bash

set -e

status_interpolation="\#{watson_status}"



get_status() {
	local num_lines=$(cat ~/.config/watson/state | wc -l)
	if [[ $num_lines = "0" ]]; then
		echo "🦥"
	else
		echo "🐝"
	fi
}

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux show-option -gqv "$option")"
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local input=$1
	local result=""

	local status=$(get_status)
	result=${input/$status_interpolation/$status}
	echo $result
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}
main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
