#!/usr/bin/env bash
#
# Magisk / KernelSU / APatch Module Builder for MiuiCamera (uke)
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SCRIPT_DIR}/out_module"
ZIP_NAME="MiuiCamera-uke-Magisk-KSU.zip"

echo "=== Building Magisk / KernelSU Module for MiuiCamera (uke) ==="

# 1. Clean previous build directory
rm -rf "${OUT_DIR}" "${SCRIPT_DIR}/${ZIP_NAME}"
mkdir -p "${OUT_DIR}/system/priv-app/MiuiCamera"
mkdir -p "${OUT_DIR}/system/etc/permissions"
mkdir -p "${OUT_DIR}/system/etc/sysconfig"
mkdir -p "${OUT_DIR}/system/lib64"

# 2. Reassemble split MiuiCamera.apk parts if needed
APK_DIR="${SCRIPT_DIR}/vendor/proprietary/system/priv-app/MiuiCamera"
if [ -f "${APK_DIR}/MiuiCamera.apk.00" ]; then
    echo "Reassembling MiuiCamera.apk..."
    cat "${APK_DIR}"/MiuiCamera.apk.* > "${OUT_DIR}/system/priv-app/MiuiCamera/MiuiCamera.apk"
elif [ -f "${APK_DIR}/MiuiCamera.apk" ]; then
    cp "${APK_DIR}/MiuiCamera.apk" "${OUT_DIR}/system/priv-app/MiuiCamera/MiuiCamera.apk"
else
    echo "Error: MiuiCamera.apk not found!"
    exit 1
fi

# 3. Copy permissions and configs
cp "${SCRIPT_DIR}/configs/privapp-permissions-miuicamera.xml" "${OUT_DIR}/system/etc/permissions/" 2>/dev/null || true
cp "${SCRIPT_DIR}/configs/miuicamera-hiddenapi-package-allowlist.xml" "${OUT_DIR}/system/etc/sysconfig/" 2>/dev/null || true
cp "${SCRIPT_DIR}/configs/public.libraries-xiaomi.txt" "${OUT_DIR}/system/etc/" 2>/dev/null || true

# 4. Copy 64-bit native libraries
VENDOR_LIB="${SCRIPT_DIR}/vendor/proprietary/system/lib64"
if [ -d "${VENDOR_LIB}" ]; then
    cp "${VENDOR_LIB}"/*.so "${OUT_DIR}/system/lib64/" 2>/dev/null || true
fi

# 5. Compile or copy libgui_shim_miuicamera.so
if [ -f "${SCRIPT_DIR}/shims/libgui_shim_miuicamera.c" ]; then
    echo "Compiling libgui_shim_miuicamera.so..."
    aarch64-linux-gnu-gcc -shared -fPIC -O2 "${SCRIPT_DIR}/shims/libgui_shim_miuicamera.c" -o "${OUT_DIR}/system/lib64/libgui_shim_miuicamera.so" 2>/dev/null || \
    clang -target aarch64-linux-gnu -shared -fPIC -O2 "${SCRIPT_DIR}/shims/libgui_shim_miuicamera.c" -o "${OUT_DIR}/system/lib64/libgui_shim_miuicamera.so" 2>/dev/null || \
    clang -shared -fPIC -O2 "${SCRIPT_DIR}/shims/libgui_shim_miuicamera.c" -o "${OUT_DIR}/system/lib64/libgui_shim_miuicamera.so" 2>/dev/null || true
fi

# 6. Create module.prop
cat << 'EOF' > "${OUT_DIR}/module.prop"
id=miuicamera-uke
name=MiuiCamera for Xiaomi Pad 7 (uke)
version=v1.0
versionCode=100
author=uke-resources
description=MIUI/HyperOS Leica Camera for Xiaomi Pad 7 (uke) on AOSP/LineageOS 23.2 (Magisk / KernelSU / APatch)
EOF

# 7. Create customize.sh
cat << 'EOF' > "${OUT_DIR}/customize.sh"
ui_print "- Installing MiuiCamera for Xiaomi Pad 7 (uke)..."
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/system/priv-app/MiuiCamera/MiuiCamera.apk 0 0 0644
set_perm $MODPATH/system/etc/permissions/privapp-permissions-miuicamera.xml 0 0 0644
ui_print "- MiuiCamera Module Installed Successfully!"
EOF

# 8. Create Magisk / KSU ZIP archive using Python
python3 -c "
import os, zipfile

out_dir = '${OUT_DIR}'
zip_path = '${SCRIPT_DIR}/${ZIP_NAME}'

with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as z:
    for root, dirs, files in os.walk(out_dir):
        for file in files:
            full_path = os.path.join(root, file)
            rel_path = os.path.relpath(full_path, out_dir)
            z.write(full_path, rel_path)

print(f'Created flashable module ZIP: {zip_path}')
"

rm -rf "${OUT_DIR}"
echo "=== Success! Magisk / KSU Module created at: ${SCRIPT_DIR}/${ZIP_NAME} ==="
