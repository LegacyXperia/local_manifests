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

# Destroy client handles after they're closed
cherries+=(71199)

# mm-core: Enable HW mp3 decoder for msm7x30
cherries+=(70946)

# ti: Add interface_mtu request
cherries+=(69839)

# libbt-vendor: Cleanup handling of all commands
cherries+=(73157)

# sensors: as3676: Allow disabling hardware ALS switch
cherries+=(72595)

# Bluetooth : Handling case: close comes before rxthread
cherries+=(70334)

# a2dp: disable music autoplay on connect based on settings
cherries+=(71674)

# settings: allow scroll in LED settings's color dialog
cherries+=(74453)

# linearlayout: fix measurement of childrens when parent and childrens have exactly the same pixels
cherries+=(74436)

# systemui: tweak expanded_status_bar_header layout
cherries+=(74382)

# Revert "Settings: refactor Profiles to be more user friendly"
cherries+=(74594)

# SoundRecorder: Bring out of gingerbread days
cherries+=(74326)

# ril: Weaken external ril symbol
cherries+=(74850)

${android}/build/tools/repopick.py -b ${cherries[@]}
