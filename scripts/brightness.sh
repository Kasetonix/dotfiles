#!/bin/zsh

# Checking if laptop's lid is open or closed
lidstatus="$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')"

# Exiting if the lid is closed
if [ $lidstatus = "closed" ]; then
    exit 1
fi

# Getting current and maximum brightness
brightCurr="$(brightnessctl get)"
brightFull="$(brightnessctl max)"

# Multiplying current brightness by 100 to get a percentage later
brightCurr=$(($brightCurr * 100))
# Calculating the percentage
brightPerc=$(($brightCurr / $brightFull))

# If statements changing the "icon"
if [ "$brightPerc" -gt "80" ]; then
	icon="  ﭳﭳﭳﭳ "
elif [ "$brightPerc" -gt "60" ]; then
	icon="  ﭳﭳﭳ— "
elif [ "$brightPerc" -gt "40" ]; then
	icon="  ﭳﭳ—— "
elif [ "$brightPerc" -gt "20" ]; then
	icon="  ﭳ——— "
elif [ "$brightPerc" -ge "0" ]; then
	icon="  ———— "
fi

# Printing the output
echo "$icon"

#vim:ft=sh
