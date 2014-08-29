#!/bin/bash

if [ -f ~/bin/paths-omni-4.4.sh ]; then
	source ~/bin/paths-omni-4.4.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Squashed revert of SoftapControllerTI changes
cherries+=(8901)

# netd: Don't reload fw if a single fw is supported
cherries+=(8902)

# wifi: remove local nl80211 header
cherries+=(8904)

# ti: Add interface_mtu request
cherries+=(8998)

# Android: Android.mk: Define ANDROID_P2P
cherries+=(9062)

# Android: driver_nl80211: implement NoA/p2p_ps/set_wps_ie stubs
cherries+=(9309)

# mm-core: Enable HW mp3 decoder for msm7x30
cherries+=(9310)

${android}/build/tools/repopick.py -b ${cherries[@]}
