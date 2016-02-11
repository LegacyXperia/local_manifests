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

# Use RECOVERY_PRE_COMMAND before calling __reboot() recovery
cherries+=(CM_115693)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_117733)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_123032)

# recovery: Add wipe system partition option
cherries+=(CM_129827)

# Add wakelock option for flashlight
cherries+=(CM_131995)

# msm7x30: Add SystemUI torch overlay
cherries+=(LX_1126)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
