#!/bin/bash

if [ -f ~/bin/paths-12.0.sh ]; then
    source ~/bin/paths-12.0.sh
fi

if [ ! -d ".repo" ]; then
    echo -e "No .repo directory found.  Is this an Android build tree?"
    exit 1
fi

if [ "${android}" = "" ]; then
    android="${PWD}"
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

# healthd: charger: Make battery capacity in charging animation opt-in
cherries+=(CM_85588)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
