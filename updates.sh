#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/bootable/recovery
# fix wired bugs due to new fs_mgr, vold and virtual device paths
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/12/51312/9 && git cherry-pick FETCH_HEAD
# - friendly write_recovery_version()
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/06/51706/1 && git cherry-pick FETCH_HEAD

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
# hostapd.conf: setting wlan1 as default interface
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/31/51131/1 && git cherry-pick FETCH_HEAD
# hostapd.conf: added greenfield support
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/32/51132/1 && git cherry-pick FETCH_HEAD
# hostapd.conf: add RX-STBC1 support
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/33/51133/1 && git cherry-pick FETCH_HEAD
# wl12xx: Import firmware & ini files from ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/24/51224/1 && git cherry-pick FETCH_HEAD

cd ${android}/system/netd
# SoftapControllerTI: enable advanced SoftAP solution
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_netd refs/changes/34/51134/1 && git cherry-pick FETCH_HEAD
# SoftapControllerTI: set correct permissions on conf file
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_netd refs/changes/35/51135/1 && git cherry-pick FETCH_HEAD
# SoftapControllerTI: override ctrl_interface with correct interface
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_netd refs/changes/36/51136/1 && git cherry-pick FETCH_HEAD

cd ${android}/external/wpa_supplicant_8_ti
# Squashed update to ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_wpa_supplicant_8_ti refs/changes/29/51129/2 && git cherry-pick FETCH_HEAD
# Fix build warning about annotated tags.
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_wpa_supplicant_8_ti refs/changes/93/51493/2 && git cherry-pick FETCH_HEAD
