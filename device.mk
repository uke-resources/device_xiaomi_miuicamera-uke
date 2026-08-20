#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

MIUICAMERA_PATH := device/xiaomi/uke-camera

# Camera
$(call soong_config_set_bool,camera,override_format_from_reserved,true)

PRODUCT_SOONG_NAMESPACES += \
    $(MIUICAMERA_PATH)

PRODUCT_PACKAGES += \
    MiuiCamera \
    libcamera_algoup_jni.xiaomi \
    libcamera_mianode_jni.xiaomi \
    libmicampostproc_client \
    vendor.xiaomi.hardware.campostproc@1.0 \
    libgui_shim_miuicamera

PRODUCT_COPY_FILES += \
    $(MIUICAMERA_PATH)/configs/privapp-permissions-miuicamera.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-miuicamera.xml \
    $(MIUICAMERA_PATH)/configs/miuicamera-hiddenapi-package-allowlist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/miuicamera-hiddenapi-package-allowlist.xml \
    $(MIUICAMERA_PATH)/configs/public.libraries-xiaomi.txt:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/public.libraries-xiaomi.txt
