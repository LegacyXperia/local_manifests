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

# sad selinux 2002
cherries+=(LAOS_164156)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(LAOS_167387)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(LAOS_167388)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
