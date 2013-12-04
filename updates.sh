#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi
# camera: Fix preview on SEMC msm7x30 devices
cherries+=(48673)

# msm7x30: Add support for camcorder mic
cherries+=(53435)

${android}/build/tools/repopick.py -b ${cherries[@]}
