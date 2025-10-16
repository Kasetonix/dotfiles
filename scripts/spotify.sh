#!/bin/sh
[ "$(pgrep -xc spotify)" -gt "0" ] || exit 1

lim=$1
[ -z lim ] || lim="32"

title="$(playerctl -p spotify metadata xesam:title)"
[ "${#title}" -eq "0" ] && exit 1 
[ "${#title}" -gt "$lim" ] && title="$(echo ${title:0:$((lim-1))}…)"

[ "$(playerctl -p spotify status)" = 'Playing' ] && status='' || status=''

echo "$status   ⟨$title⟩  "
