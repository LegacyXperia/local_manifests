#!/bin/bash

if [ -f ~/bin/paths-omni-4.4.sh ]; then
	source ~/bin/paths-omni-4.4.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# wl12xx: Ported SEMC changes
cherries+=(9097)

${android}/build/tools/repopick.py -b ${cherries[@]}
