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

# Prevent Sym key from showing the IME picker
cherries+=(54749)

# MediaProvider: fetch volume ID from MountService
cherries+=(55099)
# vold: add command allow volume id to be queried
cherries+=(55100)
# MountService: add API to fetch Volume ID through vold
cherries+=(55102)

# keyguard: fix layout for hdpi & mdpi devices
cherries+=(54758)
# SystemUI: Fix battery indicator alignment
cherries+=(54761)

# Phone: implement noise suppression for phone calls (2/2)
cherries+=(55075)

${android}/build/tools/repopick.py -b ${cherries[@]}
