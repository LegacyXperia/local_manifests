#!/bin/bash

if [ -f ~/bin/paths-10.1.sh ]; then
	source ~/bin/paths-10.1.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# "not enough rainbows, 1 star uninstall"
cherries+=(36777)
# Add support for Xperia Play touchpads
cherries+=(45903)
# Lower the RAM requirement for hardware acceleration
cherries+=(51488)
# compat-wireless: turn on TESTMODE and MAC DEBUGFS, turn off BT
cherries+=(51099)
# Squashed update to ol_R5.SP5.01
cherries+=(51223)
# libloc_api: Reduce debug level
cherries+=(51894)
# librpc: Reduce debug messages
cherries+=(51896)

${android}/build/tools/repopick.py -b ${cherries[@]}
