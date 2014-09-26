#!/bin/bash

if [ -f ~/bin/paths-omni-4.4.sh ]; then
	source ~/bin/paths-omni-4.4.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Android: Android.mk: Define ANDROID_P2P
cherries+=(9062)

# Android: driver_nl80211: implement NoA/p2p_ps/set_wps_ie stubs
cherries+=(9309)

# wl12xx: Ported SEMC changes
cherries+=(9097)

${android}/build/tools/repopick.py -b ${cherries[@]}
