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

# libutils: refbase: jellybean mr1 compat
cherries+=(79142)

# SystemUI: Update WiFi indicator drawable sizes
cherries+=(82281)

${android}/build/tools/repopick.py -b ${cherries[@]}
