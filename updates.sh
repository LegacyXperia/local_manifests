#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/build
# RepoPick: Actually skip merged commit instead of exiting
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/59/55259/2 && git cherry-pick FETCH_HEAD

cd ${android}
# camera: Fix preview on SEMC msm7x30 devices
cherries+=(48673)

# libstagefright: extend support for disabling buffer metadata
cherries+=(56416)

${android}/build/tools/repopick.py -b ${cherries[@]}
