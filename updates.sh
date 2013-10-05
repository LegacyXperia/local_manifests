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
# Navbar: Fix MDPI & HDPI landscape layout
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/01/50201/3 && git cherry-pick FETCH_HEAD
# Fix status bar brightness control when on secure lock screen
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/95/50695/2 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/ti/wlan
# compat-wireless: turn on TESTMODE and MAC DEBUGFS, turn off BT
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/99/51099/1 && git cherry-pick FETCH_HEAD
# hostapd.conf: setting wlan1 as default interface
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/00/51100/1 && git cherry-pick FETCH_HEAD
# hostapd.conf: added greenfield support
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/01/51101/1 && git cherry-pick FETCH_HEAD
# hostapd.conf: add RX-STBC1 support
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/02/51102/1 && git cherry-pick FETCH_HEAD
# wl12xx: Import firmware & ini files from ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_ti_wlan refs/changes/18/51218/1 && git cherry-pick FETCH_HEAD

cd ${android}/system/netd
# SoftapControllerTI: enable advanced SoftAP solution
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_netd refs/changes/55/51155/2 && git cherry-pick FETCH_HEAD
# SoftapControllerTI: set correct permissions on conf file
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_netd refs/changes/21/51221/1 && git cherry-pick FETCH_HEAD
# SoftapControllerTI: override ctrl_interface with correct interface
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_netd refs/changes/22/51222/1 && git cherry-pick FETCH_HEAD

cd ${android}/external/wpa_supplicant_8_ti
# Squashed update to ol_R5.SP5.01
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_wpa_supplicant_8_ti refs/changes/23/51223/1 && git cherry-pick FETCH_HEAD

cd ${android}/packages/apps/DSPManager
# Make DSPManager persistent service
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_DSPManager refs/changes/84/51384/1 && git cherry-pick FETCH_HEAD

cd ${android}/system/vold
# Make sure to exit with _exit from child
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/85/51385/1 && git cherry-pick FETCH_HEAD
# Ensure vold doesn't hang when a child process dies
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/87/51387/1 && git cherry-pick FETCH_HEAD
