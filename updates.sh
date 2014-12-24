#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(66213)

# libstagefright: Fix video encoder input buffer
cherries+=(66214)

${android}/build/tools/repopick.py -b ${cherries[@]}
