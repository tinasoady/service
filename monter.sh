#!/bin/bash

pgrep -x dmenu && exit

monter=$(lsblk -lp | grep "part $" | awk '{print $1, "(" $4 ")"}')
[[ "$monter" = "" ]] && exit 1

choix=$(echo "$monter" | dmenu -i -p "veut tu monter laquelle: " | awk '{print $1}')
[[ "$choix" = "" ]] && exit 1

sudo mount "$choix" && exit 1

dirs=$(find /mnt /media /mount /home -type d -maxdepth 3 2>nul.txt)
mountpoint=$(echo "$dirs" | dmenu -i -p "taper un lecteur a monter. ")
[[ "$mountpoint" = "" ]] && exit 1

if [[ ! -d "$mountpoint" ]] && exit 1
then
    mkdiryn=$(echo -e "oui/non" | dmenu -i -p "$mountpoint en creation, inserer le nom svp ")
    [[ "$mkdiryn" = yes ]] && sudo mkdir -p "$mountpoint"
fi

sudo mount $choix $mountpoint && pgrep -x dunst && notify-send "$choix connecter !!!"   

cd $choix
echo $(date) + %H > dte.text
cd ..

b =0
while (( $b == 0))
do
    read -p " vous voulez deconnecter o/n: " dec
    case $dec in
        o)
            ./demonter.sh
            b=1
            break;;
        n)
            echo " ok "
            b=1
            break;;
        *)    
            b=0
            break;;
    esac
done 
            
    



