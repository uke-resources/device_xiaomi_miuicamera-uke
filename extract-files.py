#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import os
import subprocess

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'vendor/xiaomi/miuicamera-uke',
]


def lib_fixup_system_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'system' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'vendor.xiaomi.hardware.campostproc@1.0': lib_fixup_system_suffix,
}

blob_fixups: blob_fixups_user_type = {
    'system/priv-app/MiuiCamera/MiuiCamera.apk': blob_fixup()
        .apktool_patch('patches'),
    'system/lib64/libcamera_algoup_jni.xiaomi.so': blob_fixup()
        .add_needed('libgui_shim_miuicamera.so')
        .sig_replace('08 AD 40 F9', '08 A9 40 F9'),
    'system/lib64/libcamera_mianode_jni.xiaomi.so': blob_fixup()
        .add_needed('libgui_shim_miuicamera.so'),
    'system/lib64/libmicampostproc_client.so': blob_fixup()
        .remove_needed('libhidltransport.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'vendor',
    'xiaomi/miuicamera-uke',
    device_rel_path='vendor/xiaomi/miuicamera-uke',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)


def split_camera_apk():
    script_dir = os.path.dirname(os.path.realpath(__file__))
    apk_dir = os.path.join(script_dir, 'vendor/proprietary/system/priv-app/MiuiCamera')
    apk_path = os.path.join(apk_dir, 'MiuiCamera.apk')
    if os.path.isfile(apk_path):
        print('Splitting extracted MiuiCamera.apk into 90M parts...')
        for f in os.listdir(apk_dir):
            if f.startswith('MiuiCamera.apk.'):
                os.remove(os.path.join(apk_dir, f))
        subprocess.run(['split', '-b', '90M', '-d', '-a', '2', apk_path, f'{apk_path}.'], check=True)
        os.remove(apk_path)
        print('Successfully split MiuiCamera.apk into 90M chunks!')


if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
    split_camera_apk()
