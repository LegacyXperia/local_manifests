CyanogenMod 10.1 for SEMC 2011 devices
===============

Local manifest needed to build cm-10.1 for the Sony Ericsson 2011 phone line.

Instructions:
-------------

Copy semc.xml into .repo/local_manifests folder in your cm10.1 tree

Working:
-------------
* Touchscreen
* Wifi
* Wifi hotspot
* Ril 2g & 3g
* SMS/MMS
* Accelerometer
* Proximity sensor
* Light sensor
* Audio
* Headphones
* Led
* Hardware Keys
* USB Connection
* GPS

Not working:
-------------
* Bluetooth
* FM Radio
* 4.2 camera
* Panorama in LegacyCamera

Pending changes on CM gerrit:
-------------
* http://review.cyanogenmod.org/32581 Externalize symbol picker options to resources
* http://review.cyanogenmod.org/32906 libstagefright: support for disabling buffer metadata
* http://review.cyanogenmod.org/28336 LegacyCamera: Load correct panorama JNI libs
* http://review.cyanogenmod.org/34989 msm7x30: Add support for SEMC FM radio
