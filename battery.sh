#!/bin/bash
##Simple unpluged ac adapter warning for those laptops which has a broken battery
##Use It in startup apps
##Test in: Dell Inspiron
##
while true
do
  #check adapter status
  bat=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state| awk '{print $2}')
  if [ "$bat" == "discharging" ]; then
   cnt=$((1))
   while [ "$bat" == "discharging" ];
   do
    per=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 |grep percentage|awk '{print $2}')
    notify-send "Battery $bat $per Warning Time $cnt" "The AC Adapter is Unpluged.\nWarning of Shutting Down.\nPlease Plugin the Charger."
    #send notify faster when user didn't reaction
    sleep 30
    cnt=$((cnt+1))
    bat=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state| awk '{print $2}')
   done
  fi
  #sleep until next check
  sleep 300
done
