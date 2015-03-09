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

# Keyguard: enlarge lockpattern on small screens
cherries+=(CM_78962)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
