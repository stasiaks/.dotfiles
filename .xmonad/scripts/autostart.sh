#!/bin/bash

# make sure it doesn't run spawn multiple instances
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

(sleep 5; run autorandr --change) &
(sleep 2; run $HOME/.config/polybar/launch.sh) &

run compton --active-opacity 1.0 --shadow-ignore-shaped
run udiskie &
run nm-applet &
run nitrogen --random ~/Pictures/Wallpapers --head=0 --set-zoom-fill &
run nitrogen --random ~/Pictures/Wallpapers --head=1 --set-zoom-fill &
run nitrogen --random ~/Pictures/Wallpapers --head=2 --set-zoom-fill &
run devilspie -a
run xsetroot -cursor_name left_ptr
