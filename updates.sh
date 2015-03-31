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
cherries+=(CM_78849)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_92943)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_81758)

# vold: add ro.vold.umsdirtyratio property
cherries+=(CM_88635)

# audio: Make getPresentationPosition pure virtual
cherries+=(CM_92978)

# audio: Initialized mAttributes in AudioTrack
cherries+=(CM_92977)

# SurfaceFlinger: Featurize libuiblur module for OSS build
cherries+=(CM_92944)

# bootloader: Silence /misc partition error
cherries+=(CM_92945)

# mogami: Fix BT deep sleep
cherries+=(LX_285)

# dashplayer: ensure dashplayer used for .mpd
cherries+=(LX_304)

# mm-video-legacy: vdec: add YUV420SP support in surface-mode
cherries+=(LX_305)

# mm-video:vdec: Fix C2D output buffer stride and sliceheight.
cherries+=(LX_306)

# mm-video: venc: do not send duplicate EBDs in case of an error
cherries+=(LX_307)

# mm-video: vdec: Avoid color conversion for Empty EOS O/P buffer.
cherries+=(LX_308)

# mm-video: vdec: allocate color-conversion buffers as uncached
cherries+=(LX_309)

# gralloc: Report YUV plane info
cherries+=(LX_310)

# gralloc: Fix NV12 and NV21 stride
cherries+=(LX_311)

# gralloc: fix getYUVPlaneInfo for YV12 format
cherries+=(LX_312)

# msm7x30-common: Update gralloc_priv.h for latest display hal
cherries+=(LX_314)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
