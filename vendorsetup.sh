#!/usr/bin/env bash
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

FDEVICE="fire"
#set -o xtrace

fox_get_target_device() {
	local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
	if [ -n "$chkdev" ]; then
		FOX_BUILD_DEVICE="$FDEVICE"
	else
		chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
		[ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
	fox_get_target_device
fi

# Dirty Fix: Only declare orangefox vars when needed
if [ -f "$(gettop)/bootable/recovery/orangefox.cpp" ]; then
	echo -e "\x1b[96m[INFO]: Setting up OrangeFox build vars for fire...\x1b[m"
	if [ "$1" = "$FDEVICE" ] || [  "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
		# Version / Maintainer infos
               	export TW_DEFAULT_LANGUAGE="en"
		            export OF_MAINTAINER="YudhoPatrianto"
		            export FOX_MAINTAINER_PATCH_VERSION=R12.1_0
		            export FOX_BUILD_TYPE="Unofficial"
	              export TARGET_DEVICE_ALT="fire"
	              export LC_ALL="C"

                # Magiskboot
	              export OF_USE_MAGISKBOOT=1
	              export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
  
            		# OTA / DM-Verity / Encryption
                export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=0
                export OF_SUPPORT_ALL_PAYLOAD_OTA_UPDATES=1
	            	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	            	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
	            	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1	
                export OF_NO_MIUI_PATCH_WARNING=1

	            	export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1
	            	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	            	export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
	            	export OF_SKIP_DECRYPTED_ADOPTED_STORAGE=1
                export OF_NO_RELOAD_AFTER_DECRYPTION=1

            		# Display / Leds
            		export OF_SCREEN_H="2400"
            		export OF_STATUS_H="100"
            		export OF_STATUS_INDENT_LEFT=48
            		export OF_STATUS_INDENT_RIGHT=48
            		export OF_HIDE_NOTCH=1
            		export OF_CLOCK_POS=1 # left and right clock positions available
	            	export OF_USE_GREEN_LED=0

	            	export FOX_USE_TAR_BINARY=1
                export FOX_USE_SED_BINARY=1
                export FOX_USE_XZ_UTILS=1
                export OF_FLASHLIGHT_ENABLE=0

	            	# Security (Disables MTP & ADB during password prompt)
	            	export OF_ADVANCED_SECURITY=1

                #Debug
                export FOX_INSTALLER_DEBUG_MODE=1

                # Metadata encription
        	      export OF_FBE_METADATA_MOUNT_IGNORE=1

                # Removes the loop block errors after flashing ZIPs (Workaround) 
                export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
  
	            	# Other OrangeFox configs
	            	export OF_ALLOW_DISABLE_NAVBAR=0
	            	export FOX_DELETE_AROMAFM=1
                export OF_USE_SYSTEM_FINGERPRINT=1
                
                # Backup
		            export OF_USE_TWRP_SAR_DETECT=1
                export OF_SKIP_MULTIUSER_FOLDERS_BACKUP="1"
	            	export FOX_REPLACE_TOOLBOX_GETPROP=1

                # run a process after formatting data to work-around MTP issues
	              export OF_RUN_POST_FORMAT_PROCESS="1"

                # let's see what are our build VARs
	        if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	           export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	           export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	           export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	           export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	        fi	    
   fi
fi
