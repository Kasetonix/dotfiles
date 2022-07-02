#!/bin/sh

if [ ! $(pgrep "spotifyd") ]; then
	spotifyd &
fi

spt;killall spotifyd
