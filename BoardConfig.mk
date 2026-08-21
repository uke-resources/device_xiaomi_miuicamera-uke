#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the proprietary version
include vendor/xiaomi/miuicamera-uke/vendor/BoardConfigVendor.mk

MIUICAMERA_PATH := vendor/xiaomi/miuicamera-uke

# Properties
TARGET_SYSTEM_PROP += $(MIUICAMERA_PATH)/system.prop
TARGET_VENDOR_PROP += $(MIUICAMERA_PATH)/vendor.prop

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(MIUICAMERA_PATH)/sepolicy/vendor
