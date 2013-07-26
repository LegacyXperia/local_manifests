#!/bin/bash

if [ "${android}" = "" ]; then
	android=~/android/system
fi


cd ${android}/hardware/qcom/audio-caf
# audio/msm7x30: Updates for MR2
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_audio-caf refs/changes/87/46087/2 && git cherry-pick FETCH_HEAD
