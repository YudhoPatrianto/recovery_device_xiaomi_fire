#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from fire device
$(call inherit-product, device/xiaomi/fire/device.mk)

# Inherit any OrangeFox-specific settings
$(call inherit-product-if-exists, $(DEVICE_PATH)/fox_fire.mk)

PRODUCT_DEVICE := fire
PRODUCT_NAME := twrp_fire
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Xiaomi Redmi 12
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_RELEASE_NAME := fire

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
