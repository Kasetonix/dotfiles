#!/bin/zsh

node_names="$(pactl list sinks | sed '/node\.name/!d; s/^\s*node\.name = //; s/"//g')"
card_names="$(pactl list sinks | sed '/\(alsa\.card_name\|media\.name\)/!d; s/^\s*\(alsa\.card_name\|media\.name\) = //; s/"//g; s/^/ /')"
sink_num="$(echo $node_names | wc -l)"
max_len="0"

while read card_name; do
    len="${#card_name}"
    [ "$len" -gt "$max_len" ] && max_len="$len"
done <<< "$card_names"

chosen_card=$(echo "$card_names" | fuzzel --dmenu --config="$HOME/.local/bin/scripts/change-sink-fuzzel-conf.ini" -l "$sink_num" --width="$(($max_len+2))" --selection-radius=12)

for i in {1.."$sink_num"}; do
    card_name=$(echo "$card_names" | sed "${i}q;d")
    [ "$card_name" = "$chosen_card" ] && chosen_node=$(echo "$node_names" | sed "${i}q;d") && break
done

pactl set-default-sink "$chosen_node" 2>/dev/null
