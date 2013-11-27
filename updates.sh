#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi
# camera: Fix preview on SEMC msm7x30 devices
cherries+=(48673)

# Clean up makefiles
cherries+=(52708)
# wpan: fix build issues
cherries+=(52709)
# wpan: Enable flag check for FM app
cherries+=(53699)

# msm7x30: Add support for camcorder mic
cherries+=(53435)

# Revert "Add Andy's ear wiggle to recovery"
cherries+=(54693)

${android}/build/tools/repopick.py -b ${cherries[@]}
