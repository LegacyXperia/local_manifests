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
cherries+=(LAOS_62450)

# libstagefright: Fix video encoder input buffer
cherries+=(LAOS_63723)

# audio: Add A2DP notification support
cherries+=(LAOS_63465)

# framework/av: Add Usb AoA v2.0 support
cherries+=(LAOS_63464)

# libstagefright: Convert mono to stereo for LPA clips
cherries+=(LAOS_63463)

# libstagefright: Stability issue with LPA play back.
cherries+=(LAOS_63462)

# frameworks/av: Fix playback for LPA audio when using gapless api
cherries+=(LAOS_63573)

# libstagefright: Fix LPA default min duration
cherries+=(LAOS_63572)

# libstagefright: Disable LPAPlayer verbose logging
cherries+=(LAOS_63571)

# libstagefright: Update LPAPlayer callbacks
cherries+=(LAOS_63478)

# input: Set explicit ioprio
cherries+=(LAOS_67360)

# surfaceflinger: Set explicit ioprio where required
cherries+=(LAOS_70229)

# display: Set thread priority using cutils
cherries+=(LAOS_75249)

# hwc: Set ioprio for vsync thread
cherries+=(LAOS_75248)

# Set IO scheduler using persist property
cherries+=(LAOS_130381)

# cutils: Squashed backport of BFQIO cgroups support
cherries+=(LAOS_143080)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
