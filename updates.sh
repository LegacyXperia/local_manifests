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
cherries+=(CM_79136)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_81758)

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(CM_84178)

# libstagefright: Fix video encoder input buffer
cherries+=(CM_84179)

# vold: add ro.vold.umsdirtyratio property
cherries+=(CM_88635)

# SurfaceFlinger: Featurize libuiblur module for OSS build
cherries+=(CM_91461)

# Fix Droid and animation color in recovery mode
cherries+=(CM_92934)

# Fix recovery image text rendering.
cherries+=(CM_92935)

# sr: Fix all the graphics issues
cherries+=(CM_92936)

# Revert old BGRA support patches
cherries+=(CM_92937)

# minui: Performance improvements
cherries+=(CM_92938)

# sr: Clean up navigation
cherries+=(CM_92940)

# mogami: Fix BT deep sleep
cherries+=(LX_285)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
