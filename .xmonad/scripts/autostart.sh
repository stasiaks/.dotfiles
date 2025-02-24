#!/bin/bash

# make sure it doesn't run spawn multiple instances
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

LAYOUT_DIRECTORY=$HOME/.screenlayout
LAYOUT_SCRIPT=$LAYOUT_DIRECTORY/set-layout.sh
if [ -f "$LAYOUT_SCRIPT" ]; then
	run $LAYOUT_SCRIPT
fi

(sleep 2; run $HOME/.config/polybar/launch.sh) &

run compton --active-opacity 1.0 --shadow-ignore-shaped
run udiskie &
run nm-applet &
run nitrogen --random ~/Pictures/Wallpapers --head=0 --set-zoom-fill &
run nitrogen --random ~/Pictures/Wallpapers --head=1 --set-zoom-fill &
run nitrogen --random ~/Pictures/Wallpapers --head=2 --set-zoom-fill &
run devilspie -a
run xsetroot -cursor_name left_ptr
run setxkbmap pl
run numlockx &

