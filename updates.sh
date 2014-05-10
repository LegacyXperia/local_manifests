#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Workspace: Quad interpolator
cherries+=(63036)

# Revert "wpa_supplicant_8 - Hostapd: Android related changes for sockets"
cherries+=(63203)

# bluedroid: increase uhid report buffer size for wiimote
cherries+=(63389)

# audio: Add A2DP notification support
cherries+=(63131)

# framework/av: Add Usb AoA v2.0 support
cherries+=(63410)

# libstagefright: Convert mono to stereo for LPA clips
cherries+=(63411)

# libstagefright: Stability issue with LPA play back.
cherries+=(63412)

# libstagefright: LPA playback fails when non-LPA clip is next clip
cherries+=(63413)

${android}/build/tools/repopick.py -b ${cherries[@]}
