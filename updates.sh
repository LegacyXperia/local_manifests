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

cd ${android}/frameworks/av
# camera: Fix preview on SEMC msm7x30 devices
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_av refs/changes/73/48673/2 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/native
# Don't use fence sync for qcom legacy
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/94/52994/1 && git cherry-pick FETCH_HEAD
# DisplayDevice: Backwards compatibility with old EGL
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/61/53161/1 && git cherry-pick FETCH_HEAD
# libgui: Bring back support for mHeap-based screenshots
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/62/53162/1 && git cherry-pick FETCH_HEAD
# hax: Split the exynos4/tegra legacy code paths
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/63/53163/1 && git cherry-pick FETCH_HEAD
# surfaceflinger: enable EGL_NEEDS_FNW for qcom legacy
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/64/53164/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/qcom/audio-caf
# audio/msm7x30: Sync audio_policy with ALSA
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_audio-caf refs/changes/97/52997/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/ti/wlan
# compat-wireless: turn on TESTMODE and MAC DEBUGFS, turn off BT
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/30/51130/1 && git cherry-pick FETCH_HEAD
# wl12xx: Import firmware & ini files from ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/24/51224/6 && git cherry-pick FETCH_HEAD
# wpa_supplicant_lib: add check for TI specific wpa_supplicant
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/07/52707/1 && git cherry-pick FETCH_HEAD
# ti/wlan: Remove obsolete files
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/88/52888/1 && git cherry-pick FETCH_HEAD

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
