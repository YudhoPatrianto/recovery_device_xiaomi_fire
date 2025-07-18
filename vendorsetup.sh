#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2022 The OrangeFox Recovery Project
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
if [ -z "${FDEVICE}" ]; then
	echo "[ERROR] FDEVICE is not set, please set it to the device codename in vendorsetup.sh!!"
	exit 1
else
	export FOX_BUILD_DEVICE="${FDEVICE}"
fi

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   echo "** WARNING **: Always set FOX_BUILD_DEVICE to the device codename before starting to build for any device!"
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	# Declarate for virtual A/B devices (Dynamic Partitions)
	export FOX_VIRTUAL_AB_DEVICE=1
	export FOX_AB_DEVICE=1

	# Keymaster
	export OF_DEFAULT_KEYMASTER_VERSION=4.1

	# Partition
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_SYSTEM_EXT_PARTITION="/dev/block/mapper/system_ext"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_RECOVERY_PRODUCT_PARTITION="/dev/block/mapper/product"

	# Maintainer
	export OF_MAINTAINER="YudhoPatrianto"

	# Build Version
	export FOX_MAINTAINER_PATCH_VERSION="1"
fi