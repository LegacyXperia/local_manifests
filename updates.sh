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

# New call-in/-back functions for Controller to do vendor-specific shutdown
cherries+=(8910)

# ti: Add interface_mtu request
cherries+=(8998)

# Android: Android.mk: Define ANDROID_P2P
cherries+=(9062)

# display-caf: Squashed merge of qcom-4.4_2.7 branch updates
cherries+=(8978)

# media-caf: Squashed merge of qcom-4.4_2.7 branch
cherries+=(8977)

# rootdir: Update cpufreq permissions when governor changes
cherries+=(8534)

# Camera: Add red-eye flash mode support
cherries+=(8527)

${android}/build/tools/repopick.py -b ${cherries[@]}
