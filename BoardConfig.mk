#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

MIUICAMERA_PATH := device/xiaomi/uke-camera

# Properties
TARGET_SYSTEM_PROP += $(MIUICAMERA_PATH)/system.prop
TARGET_VENDOR_PROP += $(MIUICAMERA_PATH)/vendor.prop

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(MIUICAMERA_PATH)/sepolicy/vendor
