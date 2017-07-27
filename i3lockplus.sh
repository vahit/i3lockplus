#!/bin/bash

# Create magical (!) lock screen image and then lock PC whit i3lock.
# Vahid.Maani@gmail.com

# check dependencies:
i3lock=$(which i3lock)
if [[ $? -ne 0 ]]; then
    echo "Install i3lock package first."
    exit 1
fi
convert=$(which convert)
if [[ $? -ne 0 ]]; then
    echo "Install imagemagick package first."
    exit 1
fi
import=$(which import)

# find base directory for script.
dir=$(dirname $0)

# Take screenshot.
import -window root $dir/pics/step1.png

# blur taken screenshot.
$convert $dir/pics/step1.png -blur 0x8 $dir/pics/step2.png

# select broken image layer randomly.
ran_num=0
while [[ $ran_num -eq 0 ]]; do
      ran_num=$(( $RANDOM % 5 ))
done      

# Merge selected layer on blured screenshot.
$convert $dir/pics/step2.png $dir/pics/bg${ran_num}.png -geometry +0+0 -composite $dir/pics/step3.png

# lock screen.
$i3lock --tiling --show-failed-attempts --image=$dir/pics/step3.png

