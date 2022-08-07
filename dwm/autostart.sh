#!/bin/sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setxkbmap pl &
xrandr --output eDP --primary --mode 1920x1080 --rate 144.15 --output HDMI-A-1-0 --mode 1920x1080 --rate 74.97 --same-as eDP &
feh --bg-fill /home/kasetonix/Pictures/Wallpapers/Singles.jpg &
DRI_PRIME=0 picom --experimental-backends &
/usr/bin/dunst &

while true; do
    xsetroot -name "$(volume)$(battery)$(clock)"
    sleep 0.1
done &
