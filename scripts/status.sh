status() {
    local started_icon="👷 "
    local stopped_icon="🏝️ "
	local num_lines=$(cat ~/.config/watson/state | wc -l)
	if [ $num_lines = "0" ]; then
		echo $stopped_icon
	else
		echo $started_icon
	fi
}

status
