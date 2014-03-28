#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Allow using Classic WebView
cherries+=(CM_56054)

${android}/vendor/extra/repopick.py -b ${cherries[@]}
