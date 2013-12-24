#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/build
# RepoPick: Actually skip merged commit instead of exiting
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/15/56215/1 && git cherry-pick FETCH_HEAD
# Fix Repopick Errors
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/89/56189/1 && git cherry-pick FETCH_HEAD

cd ${android}
# camera: Fix preview on SEMC msm7x30 devices
cherries+=(54582)

# gui: Allow devices to disable fence sync
cherries+=(52994)
# DisplayDevice: Backwards compatibility with old EGL
cherries+=(54257)
# libgui: Bring back support for mHeap-based screenshots
cherries+=(53162)

# CM PlatLogo: CyanogenMod version preference
cherries+=(55037)
# Settings: Add CM PlatLogo & CMCaseView
cherries+=(55041)

# Forward port Status Bar interface (1/2)
cherries+=(55209)
# Forward port Status Bar settings (2/2)
cherries+=(55211)

# Adds ability to answer call with hardware HOME button
cherries+=(56094)

# Navbar: Fix MDPI & HDPI landscape layout
cherries+=(56098)

# Squashed fixes for Statusbar Clock and Date actions
cherries+=(56100)

# Apollo: Add option for sorting by filename into 'Sort by' menu
cherries+=(54722)

# libc: Unbreak build for scorpion
cherries+=(56062)

# SoftapControllerTI: update parameters for setSoftap
cherries+=(55805)

# [WIP] Forward port sound settings (1/2)
cherries+=(56095)

${android}/build/tools/repopick.py -b ${cherries[@]}
