#!/bin/bash

if [ -f ~/bin/paths-omni-4.4.sh ]; then
	source ~/bin/paths-omni-4.4.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Externalize symbol picker options to resources
cherries+=(7354)

${android}/build/tools/repopick.py -b ${cherries[@]}
