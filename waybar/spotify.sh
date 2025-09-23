#!/bin/sh
lim=$1
[ $(playerctl -p spotify status) = 'Paused' ] && status='' || status=''
title="$(playerctl -p spotify metadata xesam:title)"
[ ${#title} -ge $lim ] && title="$(echo ${title:0:$((lim-1))}…)"
echo "$status  ⟨$title⟩"
