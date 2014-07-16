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

# Apply IO scheduler settings to all storage devices
cherries+=(65599)

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(66213)

# libstagefright: Fix video encoder input buffer
cherries+=(66214)

${android}/build/tools/repopick.py -b ${cherries[@]}
