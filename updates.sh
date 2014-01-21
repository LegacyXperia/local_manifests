#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Cherry-picks from CM gerrit:

# camera: Fix preview on SEMC msm7x30 devices
cherries+=(54582)

# gui: Allow devices to disable fence sync
cherries+=(52994)
# DisplayDevice: Backwards compatibility with old EGL
cherries+=(54257)

# Allow using Classic WebView
cherries+=(56054)
# Revert "Remove the classic WebView from the build."
cherries+=(56055)

# CM PlatLogo: CyanogenMod version preference
cherries+=(55037)
# Settings: Add CM PlatLogo & CMCaseView
cherries+=(55041)

# Allow changing screenoff animation (1/2)
cherries+=(54900)
# Allow changing screenoff animation (2/2)
cherries+=(54901)

# Keyguard: Fix PIN layout on sw320dp-mdpi devices
cherries+=(57557)

# Grant dev tools system permission to trigger media-scan service
cherries+=(57514)

# Performance: Allow enabling KSM by default
cherries+=(57256)

# add option to force high-end graphics on low memory devices
cherries+=(57471)
# allow forcing HighEndGfx mode
cherries+=(57303)

# don't disable lockscreen widgets on low memory devices (1/2)
cherries+=(57573)
# don't disable lockscreen widgets on low memory devices (2/2)
cherries+=(57572)

# Exclude extra LatinIME dictionaries in "mini" builds
cherries+=(57612)
# LatinIME: Allow importing external dictionaries
cherries+=(57616)

# Implement corrected sysinit (init.d) system (1/2)
cherries+=(57603)
# Implement corrected sysinit (init.d) system (2/2)
cherries+=(57604)

${android}/build/tools/repopick.py -b ${cherries[@]}

# Cherry-picks from LX gerrit:

# msm7x30: Enable KSM by default
lx_cherries+=(27)

# Revert "Don't set low RAM for now"
lx_cherries+=(82)

${android}/local_manifests/repopick.py -s auto ${lx_cherries[@]}
