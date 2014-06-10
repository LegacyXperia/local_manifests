#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Revert "wpa_supplicant_8 - Hostapd: Android related changes for sockets"
cherries+=(63203)

# Add support for Xperia Play touchpads
cherries+=(63422)

# Add UUID (re-)scan support for vold-mounted volume (1/2)
cherries+=(64436)
# Add UUID (re-)scan support for vold-mounted volume (2/2)
cherries+=(64437)

# Build FFMPEG plugin for all targets
cherries+=(65575)

${android}/build/tools/repopick.py -b ${cherries[@]}
