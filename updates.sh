#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# camera: Fix preview on SEMC msm7x30 devices
cherries+=(CM_54582)

# gui: Allow devices to disable fence sync
cherries+=(CM_52994)
# DisplayDevice: Backwards compatibility with old EGL
cherries+=(CM_54257)

# Allow using Classic WebView
cherries+=(CM_56054)
# Revert "Remove the classic WebView from the build."
cherries+=(CM_56055)

# CM PlatLogo: CyanogenMod version preference
cherries+=(CM_55037)
# Settings: Add CM PlatLogo & CMCaseView
cherries+=(CM_55041)

# Keyguard: Fix PIN layout on sw320dp-mdpi devices
cherries+=(CM_57557)

# Grant dev tools system permission to trigger media-scan service
cherries+=(CM_57514)

# Performance: Allow enabling KSM by default
cherries+=(CM_57256)

# add option to force high-end graphics on low memory devices
cherries+=(CM_57471)
# allow forcing HighEndGfx mode
cherries+=(CM_57303)

# don't disable lockscreen widgets on low memory devices (1/2)
cherries+=(CM_57573)
# don't disable lockscreen widgets on low memory devices (2/2)
cherries+=(CM_57572)

# Exclude extra LatinIME dictionaries in "mini" builds
cherries+=(CM_57612)
# LatinIME: Allow importing external dictionaries
cherries+=(CM_57616)

# cm: Add Trebuchet back to the build
cherries+=(CM_55718)

# msm7x30: Enable KSM by default
cherries+=(LX_27)

# Revert "Don't set low RAM for now"
cherries+=(LX_82)

${android}/local_manifests/repopick.py -b ${cherries[@]}
