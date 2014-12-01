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

# Android: driver_nl80211: implement NoA/p2p_ps/set_wps_ie stubs
cherries+=(78120)

# capabilities ERANG error fix
cherries+=(78853)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(79136)

# libutils: refbase: jellybean mr1 compat
cherries2+=(79142)

${android}/build/tools/repopick.py -b ${cherries[@]}
