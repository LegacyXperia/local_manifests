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

# Only try to add data_extra when we want to add it
cherries+=(CM_97855)

# Fix mounting of non-FAT formatted SD cards (1/2)
cherries+=(CM_103200)

# Fix mounting of non-FAT formatted SD cards (2/2)
cherries+=(CM_101070)

# sensors: sharp_gp2: Support the upstream gp2a kernel driver
cherries+=(CM_101102)

# sensors: sharp_gp2: do not use GNU old-style field designators
cherries+=(CM_101108)

# sensors: sharp_gp2: Correct power consumption value
cherries+=(CM_101109)

# sensors: sharp_gp2: Remove delay function in dash
cherries+=(CM_101110)

# sensors: sharp_gp2: Enable wakelocks
cherries+=(CM_101111)

# sensors: sharp_gp2: Code cleanup
cherries+=(CM_101112)

# sensors: apds970x: Code cleanup
cherries+=(CM_101113)

# sensors: apds970x: Set correct vendor name
cherries+=(CM_101114)

# sensors: as3676: Replace spaces with tabs
cherries+=(CM_101198)

# sensors: as3676: Remove unused var
cherries+=(CM_101205)

# sensors: as3676: Align cflags with upstream
cherries+=(CM_101200)

# sensors: as3676: Correct default light range
cherries+=(CM_101210)

# msm7x30-common: Remove as3676 max range
cherries+=(LX_611)

# defconfigs: semc: reduce common CMA area to 8MB
cherries+=(LX_647)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
