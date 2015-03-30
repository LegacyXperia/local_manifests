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
cherries+=(CM_92349)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_81758)

# vold: add ro.vold.umsdirtyratio property
cherries+=(CM_88635)

# audio: Make getPresentationPosition pure virtual
cherries+=(CM_92381)

# audio: Fixed Audio Source in Voice Call
cherries+=(CM_92643)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
