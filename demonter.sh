#!/bin/bash

exclu="\(/boot\|/home\|/\)$"
drive=$(lsblk -lp | grep "t /" | grep -v "exclu" | awk '{print $1, "(" $4 ")", "on" , $7}')
[[ "$drive" = "" ]] && exit 

choix=$(echo "$drive" | dmenu -i -p "demonter quelle lecteur? ") | awk '{print $1}'
[[ "$choix" = "" ]] && exit

sudo unmount $choix && pgrep -x dunst && notify-send "$choix deconnecter!!! " 
