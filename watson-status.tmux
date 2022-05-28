#!/usr/bin/env bash

set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

status_interpolation="\#{watson_status}"

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
	local result="$1"
	local status=$(get_status)
    local cmd="#($CURRENT_DIR/scripts/status.sh)"
	result=${result/$status_interpolation/${cmd}}
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
