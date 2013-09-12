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
