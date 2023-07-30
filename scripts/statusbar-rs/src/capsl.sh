#!/bin/zsh
out="$(xset q | grep "Caps Lock" | awk '{print $4}')"

if [[ $out = "on" ]]; then
	state="true"
elif [[ $out = "off" ]]; then
	state="false"
fi

echo "$state"
