#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# build: use the system's ccache by default
cherries+=(CM_58332)

# add option to force high-end graphics on low memory devices
cherries+=(CM_57471)
# allow forcing HighEndGfx mode
cherries+=(CMF_57303)

# Dialer: Add Greek T9 support
cherries+=(CM_58545)

# WLAN - wl12xx: Update to R5.SP7.01 from R5.SP5.01 package
cherries+=(CM_58549)

# Camera: Powerkey shutter (2/2)
cherries+=(CM_57946)
# Camera: Cleanup hardware key handling
cherries+=(CM_57947)
# Camera: Handle keys only while in app
cherries+=(CM_58444)
# Camera2: tweak volume key zoom and cleanup
cherries+=(CM_58809)

# Replace removed NARROW_COLUMNS layout mode with TEXT_AUTOSIZING
cherries+=(CM_58709)

# Settings: don't hide Home category if user has only 1 launcher
cherries+=(CM_58846)

# Settings LightSettingsDialog: update led on text change
cherries+=(CM_58813)

# Revert "Linkify email addresses only."
cherries+=(CM_58461)

${android}/vendor/extra/repopick.py -b ${cherries[@]}
