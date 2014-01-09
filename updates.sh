#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
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

# CM PlatLogo: CyanogenMod version preference
cherries+=(55037)
# Settings: Add CM PlatLogo & CMCaseView
cherries+=(55041)

# Adds ability to answer call with hardware HOME button
cherries+=(56094)

# SoftapControllerTI: update parameters for setSoftap
cherries+=(55805)

# LockScreen: allow long-press actions from hardware keys (1/2)
cherries+=(56346)
# LockScreen: allow long-press actions from hardware keys (2/2)
cherries+=(56357)

# Camera button support (1/2)
cherries+=(56342)
# Camera button support (2/2)
cherries+=(56345)

${android}/build/tools/repopick.py -b ${cherries[@]}

# Example of cherry-pick from LX gerrit:
# You need to uncomment the lx_cherries & repopick lines

# Performance profiles: default to 'classic' values
#lx_cherries+=(16)

#${android}/local_manifests/repopick.py -s auto ${lx_cherries[@]}
