#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

if __name__ == '__main__':
    from extract_files import module
    utils = ExtractUtils.device(module)
    utils.run_regenerate_makefiles()
