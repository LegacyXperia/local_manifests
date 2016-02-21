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

# datspinner: low resource fake material progress spinner
cherries+=(LX_1117)

# mogami-common: Remove BLE support
cherries+=(LX_1051)

# mogami-common: Remove no longer used BTHC_USERIAL_READ_MEM_SIZE
cherries+=(LX_1052)

# l2cap: Set transport even if BLE_INCLUDED = FALSE
cherries+=(CM_133778)

# art: fix dex2oat watchdog timeout
cherries+=(CM_131709)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
