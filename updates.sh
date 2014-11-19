#!/bin/bash

if [ -f ~/bin/paths-12.0.sh ]; then
	source ~/bin/paths-12.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# build: Handle boot images with custom makefile properly
cherries+=(76919)

# Revert "get rid of MemoryHeapPmem"
cherries+=(77524)

${android}/build/tools/repopick.py -b ${cherries[@]}
