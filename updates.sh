#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# build: use the system's ccache by default
cherries+=(CM_58332)

# CM PlatLogo: CyanogenMod version preference
cherries+=(CM_55037)
# Settings: Add CM PlatLogo & CMCaseView
cherries+=(CMF_55041)

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

${android}/vendor/extra/repopick.py -b ${cherries[@]}
