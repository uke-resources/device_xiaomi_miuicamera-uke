#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the proprietary version
$(call inherit-product, vendor/xiaomi/miuicamera-uke/vendor/vendor-vendor.mk)

# Camera
$(call soong_config_set_bool,camera,override_format_from_reserved,true)

# Properties
PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.miui.camera.version=3.0 \
    persist.vendor.camera.privapp.list=com.android.camera \
    vendor.camera.aux.packagelist=com.android.camera \
    persist.vendor.camera.mivi.support=0 \
    persist.sys.camera.mivi=0 \
    vendor.camera.mivi.support=0 \
    ro.camera.enableCamera1MaxZsl=1 \
    ro.camerax.extensions.enabled=true

PRODUCT_SYSTEM_PROPERTIES += \
    ro.com.google.lens.oem_camera_package=com.android.camera \
    hypercamera.disable_app_default_config=true \
    ro.miui.ui.version.name=V816 \
    ro.miui.ui.version.code=816

# Public libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries-xiaomi.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/public.libraries-xiaomi.txt

# Priv-app permission
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/privapp-permissions-miuicamera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-miuicamera.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Sysconfig
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/miuicamera-hiddenapi-package-allowlist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/miuicamera-hiddenapi-package-allowlist.xml

# Shims
PRODUCT_PACKAGES += \
    libgui_shim_miuicamera
