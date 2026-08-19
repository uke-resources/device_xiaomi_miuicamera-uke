# Xiaomi `uke` MiuiCamera Device Tree (`uke-camera`)

This repository provides the MIUI / Leica Camera (MiuiCamera) integration for Xiaomi CIVI 4 Pro / Redmi Turbo 3 (`uke`).

---

## 1. How to Include in Local Manifests

Add the following entries to your `.repo/local_manifests/uke-camera.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project path="device/xiaomi/uke-camera" name="uke-resources/device_xiaomi_uke-miuicamera" remote="github" revision="lineage-23.2" />
    <project path="vendor/xiaomi/uke-camera" name="uke-resources/vendor_xiaomi_uke-camera" remote="github" revision="lineage-23.2" />
</manifest>
```

---

## 2. Integration into Device Tree

### A. Update `BoardConfig.mk`
In `device/xiaomi/uke/BoardConfig.mk`, include the camera BoardConfig:

```makefile
# MiuiCamera
include device/xiaomi/uke-camera/BoardConfig.mk
```

### B. Update `device.mk`
In `device/xiaomi/uke/device.mk`, inherit the camera makefile:

```makefile
# MiuiCamera
$(call inherit-product, device/xiaomi/uke-camera/device.mk)
```

---

## 3. Extracting Proprietary Blobs

To extract camera blobs from a stock HyperOS dump or device:

```bash
cd device/xiaomi/uke-camera
./extract-files.py /path/to/dump
```

This will automatically extract `MiuiCamera.apk`, JNI libraries, apply required shims and apktool patches, and generate `vendor/xiaomi/uke-camera`.

---

## License
- Standard Apache-2.0 License.
