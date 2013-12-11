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

# Add option for switching between UMS and MTP/PTP mode. (2/2)
cherries+=(54903)

# Settings: Add missing up navigation in menus
cherries+=(54957)

# settings: bring back volume key cursor control
cherries+=(54894)

# Phone: implement noise suppression for phone calls (2/2)
cherries+=(55075)

# Fix a bootloop problem when /data/system/usagestats/usage-history.xml is empty.
cherries+=(55385)

# Gallery : Filter picasa specific options
cherries+=(55471)

# Parse UUID string with Long.parseLong
cherries+=(55512)

# CidKat: CyanogenMod version preference
cherries+=(55037)
# CidKat: Changes to toggle between CM and KitKat
cherries+=(55041)

${android}/build/tools/repopick.py -b ${cherries[@]}
