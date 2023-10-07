#!/bin/sh
out="$(xset q | grep "Caps Lock" | awk '{print $4}')"

if [[ $out = "on" ]]; then
	state=" "
elif [[ $out = "off" ]]; then
	state=""
fi

echo "$state"
