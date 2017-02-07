#!/bin/bash
ROUTE=~/.config/i3/pics
scrot 'fori3lock.png' -e 'mv $f ~/.config/i3/pics/fori3lock.png'
convert -blur 0x7 $ROUTE/fori3lock.png $ROUTE/final.png
convert $ROUTE/final.png $ROUTE/lockscreen.png -gravity center -composite $ROUTE/final1.png
i3lock -i $ROUTE/final1.png -e -f -n -u
