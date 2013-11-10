#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# Add support for Xperia Play touchpads
cherries+=(49310)
# Lower the RAM requirement for hardware acceleration
cherries+=(51488)
# camera: Fix preview on SEMC msm7x30 devices
cherries+=(48673)
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

${android}/build/tools/repopick.py -b ${cherries[@]}
