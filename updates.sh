#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# init.local.rc: Tweak KSM values
cherries+=(57320)

# recovery: Add support for performance control
cherries+=(56720)

# Keyguard: Fix PIN layout on sw320dp-mdpi devices
cherries+=(57558)

${android}/build/tools/repopick.py -b ${cherries[@]}

# Example of cherry-pick from LX gerrit:
# You need to uncomment the lx_cherries & repopick lines

# Performance profiles: default to 'classic' values
#lx_cherries+=(16)

#${android}/local_manifests/repopick.py -s auto ${lx_cherries[@]}
