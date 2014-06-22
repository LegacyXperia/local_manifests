#!/bin/bash

if [ -f ~/bin/paths-omni-4.4.sh ]; then
	source ~/bin/paths-omni-4.4.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# set cortex-a8 optimization for scorpion
cherries+=(7956)

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(8069)

# libstagefright: Fix video encoder input buffer
cherries+=(8070)

# Externalize symbol picker options to resources
cherries+=(7354)

${android}/build/tools/repopick.py -b ${cherries[@]}
