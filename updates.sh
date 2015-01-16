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

# nl80211: Add unhandled attributes from wpa_supplicant
cherries+=(81764)

# bcmdhd: workaround for driver compiled as a module
cherries+=(82598)

# mtdutils: Fix mounting partitions by-name
cherries+=(83404/1)

# updater: support auto detecting filesystem for mounting
cherries+=(84913)

# edify: use auto for filesystem type on mounts
cherries+=(84915)

# mount: attempt to detect filesystem if failed to mount via fstab
cherries+=(85049)

# roots: attempt to autodetect filesystem type if not vold or yaffs2
cherries+=(85314)

# fs_mgr: auto-detect filesystem when performing a check
cherries+=(85168)

# build: Allow yaffs2 to coexist with ext4/f2fs
cherries+=(85602)

${android}/build/tools/repopick.py -b ${cherries[@]}
