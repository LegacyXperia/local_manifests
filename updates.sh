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

# sensors: as3676: Allow disabling hardware ALS switch
cherries+=(72595)

# camera2: Kate Upton mode
cherries+=(72185)

# Add Screen Off option for buttons double-tap/long press (1 of 2)
cherries+=(69163)

# Add Screen Off option for buttons double-tap/long press (2 of 2)
cherries+=(69164)

# Bluetooth : Handling case: close comes before rxthread
cherries+=(70334)

# a2dp: disable music autoplay on connect based on settings
cherries+=(71674)

# Show devices connected to the WiFi hotspot(1/2)
cherries+=(66257)

# Show devices connected to the WiFi hotspot(2/2)
cherries+=(67004)

${android}/build/tools/repopick.py -b ${cherries[@]}
