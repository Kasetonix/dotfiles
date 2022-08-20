#!/bin/sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xrandr --output eDP-1 --primary --mode 1920x1080 --rate 144.15 --output HDMI-1-1 --mode 1920x1080 --rate 74.97 --same-as eDP-1 &
feh --bg-fill /home/kasetonix/pics/walls/Singles.jpg &
DRI_PRIME=0 picom --experimental-backends &
/usr/bin/dunst &

while true; do
	setxkbmap pl &
	sleep 120
done &

while true; do
    xsetroot -name "$(/home/kasetonix/.scripts/volume)$(/home/kasetonix/.scripts/battery)$(/home/kasetonix/.scripts/clock)"
    sleep 0.1
done &
