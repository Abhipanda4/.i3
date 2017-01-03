#!/bin/bash

#gnome-screenshot -d 0 -f ~/Pictures/fori3lock_temp.png
scrot 'fori3lock.png' -e 'mv $f ~/.config/i3/'
#convert -blur 0x6 -modulate 150,150 ~/Pictures/fori3lock_temp.png ~/Pictures/fori3lock.png

convert -blur 0x6 ~/.config/i3/fori3lock.png ~/.config/i3/final.png
i3lock -i ~/.config/i3/final.png -e -f
