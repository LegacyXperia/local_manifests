#!/bin/bash

if [ -f ~/bin/paths-10.1.sh ]; then
	source ~/bin/paths-10.1.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/system/core
# init: Fix serial number on semc bootloaders
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/74/38174/1 && git cherry-pick FETCH_HEAD

cd ${android}/bootable/recovery
# "not enough rainbows, 1 star uninstall"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/77/36777/3 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/base
# Add support for Xperia Play touchpads
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/03/45903/4 && git cherry-pick FETCH_HEAD
# Navbar: Fix MDPI & HDPI landscape layout
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/01/50201/2 && git cherry-pick FETCH_HEAD
# Fix status bar brightness control when on secure lock screen
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/95/50695/2 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/ti/wlan
# WLAN - compat_wl12xx: more file cleanups
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/69/50769/1 && git cherry-pick FETCH_HEAD
# WLAN - wl12xx: Update to R5.SP5.01 from R5.SP3.06 package
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/72/50772/1 && git cherry-pick FETCH_HEAD
