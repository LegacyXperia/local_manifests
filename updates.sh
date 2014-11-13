#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Apply IO scheduler settings to all storage devices
cherries+=(65599)

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(66213)

# libstagefright: Fix video encoder input buffer
cherries+=(66214)

# ti: Add interface_mtu request
cherries+=(69839)

# libbt-vendor: Cleanup handling of all commands
cherries+=(73157)

# Bluetooth : Handling case: close comes before rxthread
cherries+=(70334)

# a2dp: disable music autoplay on connect based on settings
cherries+=(71674)

# systemui: tweak expanded_status_bar_header layout
cherries+=(74382)

# Fix lockscreen selection view in landscape mode.
cherries+=(76918)

${android}/build/tools/repopick.py -b ${cherries[@]}
