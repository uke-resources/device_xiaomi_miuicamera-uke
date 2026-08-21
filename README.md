# Xiaomi Pad 7 (`uke`) MiuiCamera Vendor Tree

This repository provides the MIUI / Leica Camera (`MiuiCamera`) vendor integration for Xiaomi Pad 7 (`uke`).

---

## Integration into Device Tree

### A. Update `lineage.dependencies`
In `device/xiaomi/uke/lineage.dependencies`, map the vendor repository:

```json
[
  {
    "repository": "proprietary_vendor_xiaomi_miuicamera-uke",
    "target_path": "vendor/xiaomi/miuicamera-uke",
    "branch": "lineage-23.2"
  }
]
```

### B. Update `BoardConfig.mk`
In `device/xiaomi/uke/BoardConfig.mk`, include the camera BoardConfig:

```makefile
# MiuiCamera
-include vendor/xiaomi/miuicamera-uke/BoardConfig.mk
```

### C. Update `device.mk`
In `device/xiaomi/uke/device.mk`, inherit the camera makefile:

```makefile
# MiuiCamera
$(call inherit-product-if-exists, vendor/xiaomi/miuicamera-uke/device.mk)
```
