#!/bin/bash

if [ -f ~/bin/paths-omni-4.4.sh ]; then
	source ~/bin/paths-omni-4.4.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# build: Add QCOM target-specific config
cherries+=(7706)

# Squashed QCOM DirectTrack commits
cherries+=(7460)

# libhardware: Modify ifdefs for legacy DirectTrack
cherries+=(7652)

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(8069)

# libstagefright: Fix video encoder input buffer
cherries+=(8070)

# Revert "Revert "mm-video: venc: Correct a typo in variable name""
cherries+=(4343)

# Externalize symbol picker options to resources
cherries+=(7354)

${android}/build/tools/repopick.py -b ${cherries[@]}
