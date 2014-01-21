#!/bin/bash

if [ -f ~/bin/paths-10.1.sh ]; then
	source ~/bin/paths-10.1.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

#${android}/build/tools/repopick.py -b ${cherries[@]}
