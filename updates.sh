#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Workspace: Quad interpolator
cherries+=(63036)

# Revert "wpa_supplicant_8 - Hostapd: Android related changes for sockets"
cherries+=(63203)

# bluedroid: increase uhid report buffer size for wiimote
cherries+=(63389)

# Add support for Xperia Play touchpads
cherries+=(63422)

# Add UUID (re-)scan support for vold-mounted volume (1/2)
cherries+=(64436)

# Add UUID (re-)scan support for vold-mounted volume (2/2)
cherries+=(64437)

# cm: Enable KSM deferred timer for kernels supporting it
cherries+=(64707)

${android}/build/tools/repopick.py -b ${cherries[@]}
