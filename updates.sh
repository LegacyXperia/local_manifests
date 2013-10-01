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
# Make updating Advanced Menu a simpler task
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/13/50113/3 && git cherry-pick FETCH_HEAD
# recovery: support format external storage to custom fstype using vold
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/99/49899/3 && git cherry-pick FETCH_HEAD
# Fix extract of tgz multi volumes corruption at split point
git fetch http://review.cyanogenmod.org/CyanogenMod/android_bootable_recovery refs/changes/01/50501/1 && git cherry-pick FETCH_HEAD

cd ${android}/system/vold
# vold: Use quick format for NTFS volumes
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/20/49920/3 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/base
# Add support for Xperia Play touchpads
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/10/49310/1 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/av
# camera: Fix preview on SEMC msm7x30 devices
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_av refs/changes/73/48673/1 && git cherry-pick FETCH_HEAD

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
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_wpa_supplicant_8_ti refs/changes/29/51129/1 && git cherry-pick FETCH_HEAD

cd ${android}/build
# build: remove VideoEditor & live wallpapers from full_base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/14/50414/1 && git cherry-pick FETCH_HEAD

cd ${android}/vendor/cm
# cm: update VideoEditor & live wallpapers packages
git fetch http://review.cyanogenmod.org/CyanogenMod/android_vendor_cm refs/changes/15/50415/1 && git cherry-pick FETCH_HEAD
