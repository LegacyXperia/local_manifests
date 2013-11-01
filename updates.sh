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

cd ${android}/frameworks/native
# Revert "installd: Skip dexroot-on-cache for user builds"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/38/52738/1 && git cherry-pick FETCH_HEAD

cd ${android}/dalvik
# Revert "libdex: Skip the dexroot-on-cache stuff for user builds"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_dalvik refs/changes/39/52739/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/ti/wlan
# compat-wireless: turn on TESTMODE and MAC DEBUGFS, turn off BT
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/30/51130/1 && git cherry-pick FETCH_HEAD
# wl12xx: Import firmware & ini files from ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/24/51224/5 && git cherry-pick FETCH_HEAD
# wpa_supplicant_lib: add check for TI specific wpa_supplicant
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/07/52707/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/libhardware_legacy
# wifi: remove p2p interface on supplicant stop
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_libhardware_legacy refs/changes/30/52530/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/ti/wpan
# Clean up makefiles
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wpan refs/changes/08/52708/1 && git cherry-pick FETCH_HEAD
# wpan: fix build issues
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wpan refs/changes/09/52709/1 && git cherry-pick FETCH_HEAD
# ti-wpan-nfc-products.mk: Adding the product packages required for NFC
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wpan refs/changes/10/52710/1 && git cherry-pick FETCH_HEAD
# Squashed update of kfmapp from d-jb-mr1-release
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wpan refs/changes/11/52711/1 && git cherry-pick FETCH_HEAD
# Squashed update of FM app from d-jb-mr1-release
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wpan refs/changes/12/52712/1 && git cherry-pick FETCH_HEAD
# ti-wpan-fm-products.mk: Adding the product packages required for FM
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wpan refs/changes/13/52713/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/qcom/gps
# libloc_api: Reduce debug level
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_gps refs/changes/93/51893/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/msm7k
# librpc: Reduce debug messages
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_msm7k refs/changes/95/51895/1 && git cherry-pick FETCH_HEAD
