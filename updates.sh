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

# build: Add option to disable block-based ota
cherries+=(CM_102837)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_92943)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_81758)

# libstagefright: Add legacy LPAPlayer
cherries+=(CM_103507)

# audio: Add A2DP notification support
cherries+=(CM_103509)

# framework/av: Add Usb AoA v2.0 support
cherries+=(CM_103510)

# libstagefright: Convert mono to stereo for LPA clips
cherries+=(CM_103511)

# libstagefright: Stability issue with LPA play back.
cherries+=(CM_103512)

# frameworks/av: Fix playback for LPA audio when using gapless api
cherries+=(CM_103513)

# libstagefright: Disable LPAPlayer verbose logging
cherries+=(CM_103556)

# libstagefright: Update LPAPlayer callbacks
cherries+=(CM_109096)

# msm7x30-common: Re-enable LPA
cherries+=(LX_691)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
