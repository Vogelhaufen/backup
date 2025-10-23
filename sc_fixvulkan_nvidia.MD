# Star Citizen Linux Driver Guide

**Issue:** Star Citizen VULKAN does not work with NVIDIA driver version 580. Use version 570 instead.

---

## 1. Enable sshd

Enable `sshd` in case the system boots to a black screen. This will let you recover if the graphical interface fails.

---

## 2. Download NVIDIA Driver

Download the manual driver package from NVIDIA:

[NVIDIA Driver 570](https://www.nvidia.com/de-de/drivers/details/254657/)

---

## 3. Install Driver Manually

chmod +x NVIDIA-Linux-*.run
sudo ./NVIDIA-Linux-*.run

> The installer may fail to load `nvidia-drm` at the end. This is expected.

---

## 4. Build and Install DKMS Module

sudo dkms build nvidia -v 570.195.03  
sudo dkms install nvidia -v 570.195.03

---

## 5. Reboot

sudo reboot

---

## 6. Verify Installation

After reboot, check that the driver is active:

nvidia-smi

Star Citizen should now work correctly with driver version 570.
