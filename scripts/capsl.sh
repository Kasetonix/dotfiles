#!/bin/zsh
#out="$(xset q | grep "Caps Lock" | sed "s/.*Caps Lock://; s/01:.*//")"
out="$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')"

if [[ $out = "on" ]]; then
	ind=" "
elif [[ $out = "off" ]]; then
	ind="  "
fi

echo "$ind"
