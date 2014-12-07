#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(66213)

# libstagefright: Fix video encoder input buffer
cherries+=(66214)

# Fix lockscreen selection view in landscape mode.
cherries+=(76918)

# gralloc: Perform func to return stride and height
cherries+=(71800)

# gralloc: Fix compatibility issue
cherries+=(80951)

${android}/build/tools/repopick.py -b ${cherries[@]}
