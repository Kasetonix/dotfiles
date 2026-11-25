#!/bin/sh
function status() {
    local lim title play_icon loop_stat loop_icon
    [ "$(pgrep -xc spotify)" -gt "0" ] || exit 1

    lim=$1
    [ -z lim ] || lim="32"

    title="$(playerctl -p spotify metadata xesam:title)"
    loop_stat="$(playerctl -p spotify loop)"

    [ "${#title}" -eq "0" ] && exit 1
    [ "${#title}" -gt "$lim" ] && title="$(echo ${title:0:$((lim-1))}…)"

    [ "$(playerctl -p spotify status)" = 'Playing' ] && play_icon='' || play_icon=''

    case "$loop_stat" in
        'Playlist') loop_icon='󰑖';;
        'Track')    loop_icon='󰑘';;
        'None')     loop_icon='󰑗';;
    esac

    # echo "⟨${play_icon}|${loop_icon}⟩「${title//\&/\&amp;}」 "
    # echo "|${play_icon}⨉${loop_icon}|「${title//\&/\&amp;}」 "
    # echo "⟨${play_icon}⟩ ⟨${loop_icon}⟩「${title//\&/\&amp;}」"
    # echo "⟨${play_icon}⟩「${title//\&/\&amp;}」⟨${loop_icon}⟩"
    # echo "【${play_icon}】「${title//\&/\&amp;}」【${loop_icon}】"
    echo "  │   ${play_icon} 「${title//\&/\&amp;}」 ${loop_icon}"
}

function loop_cycle() {
    loop_stat="$(playerctl -p spotify loop)"
    case "$loop_stat" in
        'Playlist') playerctl -p spotify loop track;;
        'Track')    playerctl -p spotify loop none;;
        'None')     playerctl -p spotify loop playlist;;
    esac
}

case "$1" in
    'status')     status $2;;
    'loop_cycle') loop_cycle;;
esac
