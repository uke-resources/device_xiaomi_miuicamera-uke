# Automatically generated file. DO NOT MODIFY
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter uke,$(TARGET_DEVICE)),)

# Reassemble split MiuiCamera.apk before build
$(shell cat $(LOCAL_PATH)/proprietary/system/priv-app/MiuiCamera/MiuiCamera.apk.* > $(LOCAL_PATH)/proprietary/system/priv-app/MiuiCamera/MiuiCamera.apk 2>/dev/null)

endif
