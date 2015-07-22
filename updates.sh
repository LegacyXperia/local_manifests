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

# audio: Add A2DP notification support
cherries+=(CM_63131)

# framework/av: Add Usb AoA v2.0 support
cherries+=(CM_63410)

# libstagefright: Convert mono to stereo for LPA clips
cherries+=(CM_63411)

# libstagefright: Stability issue with LPA play back.
cherries+=(CM_63412)

# frameworks/av: Fix playback for LPA audio when using gapless api
cherries+=(CM_103480)

# libstagefright: Fix LPA default min duration
cherries+=(CM_103549)

# libstagefright: Disable LPAPlayer verbose logging
cherries+=(CM_103550)

# memcg: add memory.pressure_level events
cherries+=(LX_705)

# introduce for_each_thread() to replace the buggy while_each_thread()
cherries+=(LX_703)

# mm, oom: make dump_tasks public
cherries+=(LX_710)

# mm: vmpressure: allow in-kernel clients to subscribe for events
cherries+=(LX_706)

# mm: Add notifier framework for showing memory
cherries+=(LX_707)

# android/lowmemorykiller: Account for total_swapcache_pages
cherries+=(LX_693)

# lowmemorykiller: Don't count swap cache pages twice
cherries+=(LX_695)

# lowmemorykiller: use for_each_thread instead of buggy while_each_thread
cherries+=(LX_696)

# lowmemorykiller: enhance debug information
cherries+=(LX_697)

# lowmemorykiller: Dump out slab state information
cherries+=(LX_698)

# lowmemorykiller: Run the lowmemory notifier when killing
cherries+=(LX_699)

# lowmemorykiller: Do proper NULL checks
cherries+=(LX_700)

# lowmemorykiller: adapt to vmpressure
cherries+=(LX_701)

# msm7x30-common: Enable adaptive LMK
cherries+=(LX_702)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
