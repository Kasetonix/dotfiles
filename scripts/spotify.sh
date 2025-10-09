#!/bin/sh
lim=$1
[ -z lim ] || lim="32"
[ $(pgrep spotify) ] && exit 1
[ $(playerctl -p spotify status) = 'Paused' ] && status='' || status=''
title="$(playerctl -p spotify metadata xesam:title)"
[ "${#title}" -gt "$lim" ] && title="$(echo ${title:0:$((lim-1))}…)"
echo "$status   ⟨$title⟩"
