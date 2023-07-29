#!/bin/zsh

bat0="/sys/class/power_supply/BAT0"
bat1="/sys/class/power_supply/BAT1"
ac="/sys/class/power_supply/AC"

# Reading the charge levels and states of the batteries + state of the charger
bat0Curr="$(cat $bat0/energy_now)"; bat0Full="$(cat $bat0/energy_full)"
bat0Status="$(cat $bat0/status)"

if [[ -d $bat1 ]]; then # if bat1 exists
	bat1Curr="$(cat $bat1/energy_now)"; bat1Full="$(cat $bat1/energy_full)"
    bat1Status="$(cat $bat1/status)"
else
	bat1Curr="0"; bat1Full="0"
    bat1Status="Not charging"
fi

acStatus="$(cat $ac/online)"

# Calculating the percentage of the batteries combined
batCurr=$(($bat0Curr+$bat1Curr))
batFull=$(($bat0Full+$bat1Full))
batCurrPerc=$(($batCurr*100))
perc=$(($batCurrPerc/$batFull))

# Writing the state
if [[ $bat0Status = "Charging" ]] || [[ $bat1Status = "Charging" ]]; then
    if [ $perc -ge 99 ]; then
        batStatus="" # "Full" and charging 
    else
        batStatus="" # Charging
    fi
elif [[ $bat0Status = "Discharging" ]] || [[ $bat1Status = "Discharging" ]]; then
    if [ $perc -gt 10 ]; then;
        batStatus="" # Discharging
    elif [ $perc -gt 5 ]; then
        batStatus="" # Low Battery
    else
        if (( $(date "+%S") % 2 == 0 )); then
            batStatus="" # Low Battery++
        else 
            batStatus=" "
        fi
    fi
else 
    batStatus="~" # <- for when something weird happens
fi

# Showing the correct percentage and state
if [ "$perc" -ge "95" ]; then
	icon="   $batStatus "
elif [ "$perc" -ge "75" ]; then
	icon="   $batStatus "
elif [ "$perc" -ge "50" ]; then
	icon="   $batStatus "
elif [ "$perc" -ge "25" ]; then
	icon="   $batStatus "
elif [ "$perc" -lt "25" ]; then
	icon="   $batStatus "
fi

echo $icon

#vim:ft=sh
