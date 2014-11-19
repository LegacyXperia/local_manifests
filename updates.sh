#!/bin/bash

if [ -f ~/bin/paths-12.0.sh ]; then
	source ~/bin/paths-12.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# build: recovery: Support adding device-specific items
cherries+=(76553)

# build: Handle boot images with custom makefile properly
cherries+=(76919)

# Revert "get rid of MemoryHeapPmem"
cherries+=(77524)

# mkbootimg: Support 32K 64K and 128K pagesizes
cherries+=(78055)

${android}/build/tools/repopick.py -b ${cherries[@]}
