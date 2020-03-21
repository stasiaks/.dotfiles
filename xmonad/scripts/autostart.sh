#!/bin/bash

# make sure it doesn't run spawn multiple instances
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

(sleep 2; run $HOME/.config/polybar/launch.sh) &
