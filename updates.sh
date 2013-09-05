#!/bin/bash

source ~/bin/paths-10.1.sh

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

cd ${android}/frameworks/native
# Configure dalvik heap parameters for low memory devices
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/85/47285/1 && git cherry-pick FETCH_HEAD

cd ${android}/dalvik
# dalvik/vm: Dalvik startup with a low memory footprint
git fetch http://review.cyanogenmod.org/CyanogenMod/android_dalvik refs/changes/57/47757/1 && git cherry-pick FETCH_HEAD

cd ${android}/packages/apps/Torch
# Torch: only write to sysfs if not already on
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_Torch refs/changes/74/49874/1 && git cherry-pick FETCH_HEAD
