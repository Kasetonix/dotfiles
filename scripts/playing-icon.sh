#!/bin/bash

if [ "$(playerctl status)" == "Playing" ]
then
	echo ""
elif [ "$(playerctl status)" == "Paused" ]
then
	echo ""
fi

	
