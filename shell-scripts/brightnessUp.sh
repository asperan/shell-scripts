#!/bin/zsh

# Increase backlight of 10%
xbacklight -inc 10

# Get the value of the current brightness
BRIGHTNESS=`xrandr --properties | grep Backlight | cut -d ' ' -f2`

# compute the percent of the brightness rounded at 1 decimal
FORMAT=$(printf "%.1f" $(echo "scale=1; ${BRIGHTNESS}*100/937" | bc))

# Send a notitifaction with the percentage
notify-send --app-name="Brightness" -t 500 "${FORMAT}%"
