#!/bin/bash

if [ ! -d ".repo" ]; then
    echo -e "No .repo directory found.  Is this an Android build tree?"
    exit 1
fi

android="${PWD}"

# Add local cherries if they exist
if [ -f ${android}/updates-local.sh ]; then
    source ${android}/updates-local.sh
fi

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(CM_66213)

# libstagefright: Fix video encoder input buffer
cherries+=(CM_66214)

# audio: Add A2DP notification support
cherries+=(CM_63131)

# framework/av: Add Usb AoA v2.0 support
cherries+=(CM_63410)

# libstagefright: Convert mono to stereo for LPA clips
cherries+=(CM_63411)

# libstagefright: Stability issue with LPA play back.
cherries+=(CM_63412)

# frameworks/av: Fix playback for LPA audio when using gapless api
cherries+=(CM_103480)

# libstagefright: Fix LPA default min duration
cherries+=(CM_103549)

# libstagefright: Disable LPAPlayer verbose logging
cherries+=(CM_103550)

# libstagefright: Update LPAPlayer callbacks
cherries+=(CM_109071)

# input: Set explicit ioprio
cherries+=(CM_123930)

# surfaceflinger: Set explicit ioprio where required
cherries+=(CM_123932)

# display: Set thread priority using cutils
cherries+=(CM_123933)

# hwc: Set ioprio for vsync thread
cherries+=(CM_123934)

# Set IO scheduler using persist property
cherries+=(CM_123935)

# cutils: Squashed backport of BFQIO cgroups support
cherries+=(CM_123936)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
