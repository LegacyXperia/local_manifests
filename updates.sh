#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# camera: Fix preview on SEMC msm7x30 devices
cherries+=(54582)

# gui: Allow devices to disable fence sync
cherries+=(52994)
# DisplayDevice: Backwards compatibility with old EGL
cherries+=(54257)
# libgui: Bring back support for mHeap-based screenshots
cherries+=(53162)

# Use AOSP version of wpa_supplicant_lib
cherries+=(54289)

# vold: save fat partition volume id to system prop
cherries+=(54610)
# MediaProvider: read fat volume id from prop
cherries+=(54609)

${android}/build/tools/repopick.py -b ${cherries[@]}
