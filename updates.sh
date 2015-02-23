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
cherries+=(78849)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(79136)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(81758)

# libstagefright: Allow using camera recording buffer as input for encoder
cherries+=(84178)

# libstagefright: Fix video encoder input buffer
cherries+=(84179)

# vold: add ro.vold.umsdirtyratio property
cherries+=(88635)

# mount: respect a user-specified fstype
cherries+=(88592)

# get_devname: fix a couple warnings
cherries+=(89206)

# healthd: charger: Make battery capacity in charging animation opt-in
cherries+=(85588)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/build/tools/repopick.py -b ${cherries[@]}
fi
