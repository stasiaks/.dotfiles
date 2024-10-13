#!/bin/sh

C_CLASS_SET="$(yadm config --get-all local.class)"
echo "Current YADM classes:"
echo $C_CLASS_SET

yadm config --unset-all local.class

# --- BEGIN - DETERMINE CLASSES

if ( ls /sys/class/power_supply/BAT0/capacity >> /dev/null 2>&1 ); then
	yadm config --add local.class laptop
fi

if ( lspci -v | grep -A1 -e VGA -e 3D | grep -ie nvidia >> /dev/null 2>&1 ); then
	yadm config --add local.class gpu_nvidia
fi

if ( lspci -v | grep -A1 -e VGA -e 3D | grep -ie intel >> /dev/null 2>&1 ); then
	yadm config --add local.class gpu_intel
fi

if ( lspci -v | grep -A1 -e VGA -e 3D | grep -ie amd >> /dev/null 2>&1 ); then
	yadm config --add local.class gpu_amd
fi

# --- END - DETERMINE CLASSES

F_CLASS_SET="$(yadm config --get-all local.class)"

if [ "$C_CLASS_SET" = "$F_CLASS_SET" ]; then
	echo "Classes did not change"
else
	yadm alt
	echo "Classes changed - rerun yadm bootstrap" >&2
	exit 1
fi
