#!/bin/bash

if [ -f ~/bin/paths-omni-4.4.sh ]; then
	source ~/bin/paths-omni-4.4.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

#${android}/vendor/extra/repopick.py -b ${cherries[@]}
