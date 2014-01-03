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

cd ${android}
# camera: Fix preview on SEMC msm7x30 devices
cherries+=(54582)

# gui: Allow devices to disable fence sync
cherries+=(52994)
# DisplayDevice: Backwards compatibility with old EGL
cherries+=(54257)

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

# SoftapControllerTI: update parameters for setSoftap
cherries+=(55805)

# LockScreen: allow long-press actions from hardware keys (1/2)
cherries+=(56346)
# LockScreen: allow long-press actions from hardware keys (2/2)
cherries+=(56357)

# [WIP] Camera button support (1/2)
cherries+=(56342)
# [WIP] Camera button support (2/2)
cherries+=(56345)

${android}/build/tools/repopick.py -b ${cherries[@]}
