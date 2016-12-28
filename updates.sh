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

# selinux: add selinux_status_getenforce to header
cherries+=(LAOS_60713)

# init: don't skip starting a service with no domain if permissive
cherries+=(LAOS_142846)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(LAOS_1175)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(LAOS_2643)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
