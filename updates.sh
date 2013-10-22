#!/bin/bash

if [ -f ~/bin/paths-10.1.sh ]; then
	source ~/bin/paths-10.1.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/bootable/recovery
# "not enough rainbows, 1 star uninstall"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/77/36777/3 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/base
# Add support for Xperia Play touchpads
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/03/45903/4 && git cherry-pick FETCH_HEAD
# Lower the RAM requirement for hardware acceleration
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/88/51488/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/ti/wlan
# compat-wireless: turn on TESTMODE and MAC DEBUGFS, turn off BT
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/99/51099/1 && git cherry-pick FETCH_HEAD
# wl12xx: Import firmware & ini files from ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/18/51218/2 && git cherry-pick FETCH_HEAD

cd ${android}/external/wpa_supplicant_8_ti
# Squashed update to ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_wpa_supplicant_8_ti refs/changes/23/51223/2 && git cherry-pick FETCH_HEAD
# Fix build warning about annotated tags.
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_wpa_supplicant_8_ti refs/changes/33/51633/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/qcom/gps
# libloc_api: Reduce debug level
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_gps refs/changes/94/51894/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/msm7k
# librpc: Reduce debug messages
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_msm7k refs/changes/96/51896/1 && git cherry-pick FETCH_HEAD
