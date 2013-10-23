#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/frameworks/base
# Add support for Xperia Play touchpads
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/10/49310/1 && git cherry-pick FETCH_HEAD
# Lower the RAM requirement for hardware acceleration
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/88/51488/1 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/av
# camera: Fix preview on SEMC msm7x30 devices
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_av refs/changes/73/48673/2 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/ti/wlan
# compat-wireless: turn on TESTMODE and MAC DEBUGFS, turn off BT
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/30/51130/1 && git cherry-pick FETCH_HEAD
# wl12xx: Import firmware & ini files from ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/24/51224/1 && git cherry-pick FETCH_HEAD

cd ${android}/external/wpa_supplicant_8_ti
# Squashed update to ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_wpa_supplicant_8_ti refs/changes/29/51129/2 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/qcom/gps
# libloc_api: Reduce debug level
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_gps refs/changes/93/51893/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/msm7k
# librpc: Reduce debug messages
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_msm7k refs/changes/95/51895/1 && git cherry-pick FETCH_HEAD
