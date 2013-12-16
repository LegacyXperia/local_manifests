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

# Add option for switching between UMS and MTP/PTP mode. (2/2)
cherries+=(54903)

# Phone: implement noise suppression for phone calls (2/2)
cherries+=(55075)

# CidKat: CyanogenMod version preference
cherries+=(55037)
# CidKat: Changes to toggle between CM and KitKat
cherries+=(55041)

# SoftapControllerTI: update parameters for setSoftap
cherries+=(55805)

${android}/build/tools/repopick.py -b ${cherries[@]}
