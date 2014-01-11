#!/bin/bash

if [ -f ~/bin/paths-10.2.sh ]; then
	source ~/bin/paths-10.2.sh
fi

if [ "${android}" = "" ]; then
	android=~/android/system
fi

# camera: Fix preview on SEMC msm7x30 devices
cherries+=(48673)

# msm7x30: Add support for SEMC camcorder mic
cherries+=(53435)

# libstagefright: extend support for disabling buffer metadata
cherries+=(56416)

# init.local.rc: Tweak KSM values
cherries+=(57320)

# recovery: Fix the configuration of default_backup_format
cherries+=(57178)

# recovery: Add support for performance control
cherries+=(56720)

# Settings: fix led pulsespeedoff disable behaviour
cherries+=(56866)

${android}/build/tools/repopick.py -b ${cherries[@]}

# Example of cherry-pick from LX gerrit:
# You need to uncomment the lx_cherries & repopick lines

# Performance profiles: default to 'classic' values
#lx_cherries+=(16)

#${android}/local_manifests/repopick.py -s auto ${lx_cherries[@]}
