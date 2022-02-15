#!/bin/sh
### Created by ilsenatorov
### Change WALLPAPERDIR to the directory where you store wallpapers

WALLPAPERDIR=~/Pictures/Wallpapers/

if [ -z $@ ]
then
function get_themes()
{
    ls $WALLPAPERDIR
}
echo current; get_themes
else
    THEMES=$@
    if [ x"current" = x"${THEMES}" ]
    then
        exit 0
        #wal -i `cat ~/.cache/wal/wal` > /dev/null
    elif [ -n "${THEMES}" ]
    then
        nitrogen --head=0 --set-zoom-fill $WALLPAPERDIR${THEMES} > /dev/null &
        nitrogen --head=1 --set-zoom-fill $WALLPAPERDIR${THEMES} > /dev/null &
    fi
fi

