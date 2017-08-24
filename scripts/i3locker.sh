#!/bin/bash
# script for fancy i3lock in multi-monitor system
# Check guimeira/i3lock-fancy-multimonitor for a generalized version

ROUTE=~/.config/i3/pics
LOCK_IMG=$ROUTE/lock_icon.png
details=`identify $LOCK_IMG`
SIZE_REG="([0-9]+)x([0-9]+)"

# Get the dimensions of the lock icon
[[ $details =~ $SIZE_REG ]]
IMG_WIDTH=${BASH_REMATCH[1]}
IMG_HEIGHT=${BASH_REMATCH[2]}

# Blurred Image of current screen for background
scrot 'fori3lock.png' -e 'mv $f ~/.config/i3/pics/fori3lock.png'
convert -blur 5x3 $ROUTE/fori3lock.png $ROUTE/blurred_shot.png

DISPLAY_REG="([0-9]+)x([0-9]+)\\+([0-9]+)\\+([0-9]+)"

while read LINE
do
	# line is of the form:
	# device connected (...) widthxheight+x_offset+y_offset (dimensions)
	# no of lines = no of screens connected
	[[ $LINE =~ $DISPLAY_REG ]]
	WIDTH=${BASH_REMATCH[1]}
	HEIGHT=${BASH_REMATCH[2]}
	X_OFF=${BASH_REMATCH[3]}
	Y_OFF=${BASH_REMATCH[4]}

	# calculate the position of image on each screen
	# The following calculation ensures middle alignment along each axis
	POS_X=$(($X_OFF+$WIDTH/2-$IMG_WIDTH/2))
	POS_Y=$(($Y_OFF+$HEIGHT/2-$IMG_HEIGHT/2))

	# build the argument for convert command
	ARGS="$ARGS '$LOCK_IMG' '-geometry' '+$POS_X+$POS_Y' '-composite'"

done <<< "`xrandr | grep mm`"

#convert $ROUTE/blurred.png $full_image -gravity center -composite $ROUTE/display.png
ARGS="'$ROUTE/blurred_shot.png' $ARGS '$ROUTE/final_img.png'"
eval convert $ARGS

i3lock -i $ROUTE/final_img.png -t
