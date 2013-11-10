#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Add support for Xperia Play touchpads
cherries+=(49310)
# camera: Fix preview on SEMC msm7x30 devices
cherries+=(48673)
# Don't use fence sync for qcom legacy
cherries+=(52994)
# DisplayDevice: Backwards compatibility with old EGL
cherries+=(53161)
# libgui: Bring back support for mHeap-based screenshots
cherries+=(53162)
# hax: Split the exynos4/tegra legacy code paths
cherries+=(53163)
# surfaceflinger: enable EGL_NEEDS_FNW for qcom legacy
cherries+=(53164)
# audio/msm7x30: Sync audio_policy with ALSA
cherries+=(52997)
# compat-wireless: turn on TESTMODE and MAC DEBUGFS, turn off BT
cherries+=(51130)
# wl12xx: Import firmware & ini files from ol_R5.SP5.01
cherries+=(51224)
# wpa_supplicant_lib: add check for TI specific wpa_supplicant
cherries+=(52707)
# ti/wlan: Remove obsolete files
cherries+=(52888)
# wifi: remove p2p interface on supplicant stop
cherries+=(52530)
# Clean up makefiles
cherries+=(52708)
# wpan: fix build issues
cherries+=(52709)
# ti-wpan-nfc-products.mk: Adding the product packages required for NFC
cherries+=(52710)
# Squashed update of kfmapp from d-jb-mr1-release
cherries+=(52711)
# Squashed update of FM app from d-jb-mr1-release
cherries+=(52712)
# ti-wpan-fm-products.mk: Adding the product packages required for FM
cherries+=(52713)
# libloc_api: Reduce debug level
cherries+=(51893)

./build/tools/repopick.py -b ${cherries[@]}
