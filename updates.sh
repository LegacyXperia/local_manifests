#!/bin/bash

if [ "${android}" = "" ]; then
	android=~/android/system
fi

cd ${android}/system/core
# init: Fix serial number on semc bootloaders
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/74/38174/1 && git cherry-pick FETCH_HEAD

cd ${android}/hardware/qcom/audio-caf
# audio/msm7x30: Updates for MR2
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_audio-caf refs/changes/87/46087/2 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/av
# libstagefright: support for disabling buffer metadata
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_av refs/changes/95/46495/1 && git cherry-pick FETCH_HEAD

cd ${android}/frameworks/native
# surfaceflinger: enable EGL_NEEDS_FNW for qcom legacy
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/59/47259/1 && git cherry-pick FETCH_HEAD
