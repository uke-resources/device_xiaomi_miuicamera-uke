# Xiaomi Pad 7 (`uke`) MiuiCamera Device Tree

This repository provides the self-contained MIUI / Leica Camera (MiuiCamera) integration for Xiaomi Pad 7 (`uke`).

---

## Integration into Device Tree

### A. Update `BoardConfig.mk`
In `device/xiaomi/uke/BoardConfig.mk`, include the camera BoardConfig:

```makefile
# MiuiCamera
include device/xiaomi/miuicamera-uke/BoardConfig.mk
```

### B. Update `device.mk`
In `device/xiaomi/uke/device.mk`, inherit the camera makefile:

```makefile
# MiuiCamera
$(call inherit-product, device/xiaomi/miuicamera-uke/device.mk)
```
