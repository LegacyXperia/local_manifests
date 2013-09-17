#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/system/core
# init: Fix serial number on semc bootloaders
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/10/50410/1 && git cherry-pick FETCH_HEAD

cd ${android}/bootable/recovery
# "not enough rainbows, 1 star uninstall"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/64/49064/1 && git cherry-pick FETCH_HEAD
# recovery: support format external storage to custom fstype using vold
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/99/49899/3 && git cherry-pick FETCH_HEAD

cd ${android}/system/vold
# vold: Use quick format for NTFS volumes
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/20/49920/3 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/base
# Add support for Xperia Play touchpads
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/10/49310/1 && git cherry-pick FETCH_HEAD
# Navbar: Fix MDPI & HDPI landscape layout
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/00/50200/2 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/av
# camera: Fix preview on SEMC msm7x30 devices
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_av refs/changes/73/48673/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/qcom/gps
# libloc_api: Fix some compiler warnings
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_gps refs/changes/53/49853/1 && git cherry-pick FETCH_HEAD

cd ${android}/build
# build: remove VideoEditor & live wallpapers from full_base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/14/50414/1 && git cherry-pick FETCH_HEAD

cd ${android}/vendor/cm
# cm: update VideoEditor & live wallpapers packages
git fetch http://review.cyanogenmod.org/CyanogenMod/android_vendor_cm refs/changes/15/50415/1 && git cherry-pick FETCH_HEAD
