#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# CM PlatLogo: CyanogenMod version preference
cherries+=(CM_55037)
# Settings: Add CM PlatLogo & CMCaseView
cherries+=(CMF_55041)

# add option to force high-end graphics on low memory devices
cherries+=(CM_57471)
# allow forcing HighEndGfx mode
cherries+=(CMF_57303)

# cm: Add Trebuchet back to the build
cherries+=(CM_55718)

# Revert "Don't set low RAM for now"
cherries+=(LX_82)

${android}/vendor/extra/repopick.py -b ${cherries[@]}
