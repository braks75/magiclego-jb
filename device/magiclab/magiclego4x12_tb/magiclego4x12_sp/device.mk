# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# This file is the device-specific product definition file for
# magiclego4x12. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# Note that magiclego4x12 is not a fully open device. Some of the drivers
# aren't publicly available in all circumstances, which means that some
# of the hardware capabilities aren't present in builds where those
# drivers aren't available. Such cases are handled by having this file
# separated into two halves: this half here contains the parts that
# are available to everyone, while another half in the vendor/ hierarchy
# augments that set with the parts that are only relevant when all the
# associated drivers are available. Aspects that are irrelevant but
# harmless in no-driver builds should be kept here for simplicity and
# transparency. There are two variants of the half that deals with
# the unavailable drivers: one is directly checked into the unreleased
# vendor tree and is used by engineers who have access to it. The other
# is generated by setup-makefile.sh in the same directory as this files,
# and is used by people who have access to binary versions of the drivers
# but not to the original vendor tree. Be sure to update both.



# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.

DEVICE_NAME := magiclego4x12_sp
include $(LOCAL_PATH)/BoardConfig.mk

# These are for the multi-storage mount.
source_vold_fstab_file := $(LOCAL_PATH)/conf/vold.fstab
PRODUCT_COPY_FILES += $(source_vold_fstab_file):system/etc/vold.fstab

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

ifeq ($(BOARD_USES_HGL),true)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/conf/egl.cfg:system/lib/egl/egl.cfg \
	device/samsung/exynos4/lib/mali_ump/libEGL_mali.so:system/lib/egl/libEGL_mali.so \
	device/samsung/exynos4/lib/mali_ump/libGLESv1_CM_mali.so:system/lib/egl/libGLESv1_CM_mali.so \
	device/samsung/exynos4/lib/mali_ump/libGLESv2_mali.so:system/lib/egl/libGLESv2_mali.so \
	device/samsung/exynos4/lib/mali_ump/libMali.so:system/lib/libMali.so \
	device/samsung/exynos4/lib/mali_ump/libMali.so:obj/lib/libMali.so \
	device/samsung/exynos4/lib/mali_ump/libUMP.so:system/lib/libUMP.so \
	device/samsung/exynos4/lib/mali_ump/libUMP.so:obj/lib/libUMP.so \
	device/samsung/exynos4/lib/mali_ump/libion.so:system/lib/libion.so \
	device/samsung/exynos4/lib/mali_ump/libion.so:obj/lib/libion.so
endif

# Init files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/conf/init.magiclego4x12.rc:root/init.$(DEVICE_NAME).rc \
	$(LOCAL_PATH)/conf/init.usb.rc:root/init.usb.rc

# For V4L2
ifeq ($(BOARD_USE_V4L2), true)
ifeq ($(BOARD_USE_V4L2_ION), true)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/conf/ueventd.magiclego4x12.v4l2ion.rc:root/ueventd.$(DEVICE_NAME).rc
else
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/conf/ueventd.magiclego4x12.v4l2.rc:root/ueventd.$(DEVICE_NAME).rc
endif
else
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/conf/ueventd.magiclego4x12.rc:root/ueventd.$(DEVICE_NAME).rc
endif

# Prebuilt kl keymaps
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/samsung-keypad.kl:system/usr/keylayout/samsung-keypad.kl

# Generated kcm keymaps
PRODUCT_PACKAGES := \
	samsung-keypad.kcm

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs

# audio
PRODUCT_PACKAGES += \
	audio_policy.$(DEVICE_NAME) \
	audio.primary.$(DEVICE_NAME) \
	audio.a2dp.default \
	libaudioutils

# ULP Audio
ifeq ($(USE_ULP_AUDIO),true)
PRODUCT_PACKAGES += \
	libaudiohw \
	MusicULP \
	libsa_jni
endif

# ALP Audio
ifeq ($(BOARD_USE_ALP_AUDIO),true)
PRODUCT_PACKAGES += \
	libOMX.SEC.MP3.Decoder
endif



# Camera
PRODUCT_PACKAGES += \
	camera.$(DEVICE_NAME)
# SEC_Camera
ifeq ($(USE_SEC_CAMERA),true)
PRODUCT_PACKAGES += \
	SEC_Camera
endif

# Libs
PRODUCT_PACKAGES += \
	libcamera \
	libstagefrighthw \
	com.android.future.usb.accessory

# Video Editor
PRODUCT_PACKAGES += \
	VideoEditorGoogle

# Misc other modules
PRODUCT_PACKAGES += \
	lights.$(DEVICE_NAME) \
	sensors.$(DEVICE_NAME) \
	hwcomposer.exynos4

# Widevine DRM
PRODUCT_PACKAGES += com.google.widevine.software.drm.xml \
	com.google.widevine.software.drm \
	WidevineSamplePlayer \
	test-libwvm \
	test-wvdrmplugin \
	test-wvplayer_L1 \
	libdrmwvmplugin \
	libwvm \
	libWVStreamControlAPI_L1 \
	libwvdrm_L1

# OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml

# OpenMAX IL modules
PRODUCT_PACKAGES += \
	libSEC_OMX_Core \
	libSEC_OMX_Resourcemanager \
	libOMX.SEC.AVC.Decoder \
	libOMX.SEC.M4V.Decoder \
	libOMX.SEC.M4V.Encoder \
	libOMX.SEC.AVC.Encoder

# hwconvertor modules
PRODUCT_PACKAGES += \
	libhwconverter \

# MFC firmware
PRODUCT_COPY_FILES += \
	device/samsung/exynos4/firmware/mfc_fw.bin:system/vendor/firmware/mfc_fw.bin

# FIMC-IS firmware
PRODUCT_COPY_FILES += \
	device/samsung/exynos4/firmware/fimc_is_fw.bin:system/vendor/firmware/fimc_is_fw.bin \
	device/samsung/exynos4/firmware/setfile.bin:system/vendor/firmware/setfile.bin

# Input device calibration files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/atmel_mxt_ts.idc:system/usr/idc/atmel_mxt_ts.idc

PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072

PRODUCT_PROPERTY_OVERRIDES += \
	hwui.render_dirty_regions=false

# Widevine DRM
PRODUCT_PROPERTY_OVERRIDES += \
	drm.service.enabled=true

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

ifeq ($(BOARD_USES_HIGH_RESOLUTION_LCD),true)
PRODUCT_CHARACTERISTICS := tablet

PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

$(call inherit-product, frameworks/base/build/tablet-dalvik-heap.mk)

else
PRODUCT_CHARACTERISTICS := phone

PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

$(call inherit-product, frameworks/base/build/phone-hdpi-512-dalvik-heap.mk)

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=240

PRODUCT_AAPT_CONFIG := small hdpi
endif

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# added for MTK MT6620
ifeq ($(BOARD_HAVE_MTK_MT6620),true)
  include $(LOCAL_PATH)/../common/mt6620/mt6620_product_package.mk
endif

# Include ymu828b product package
ifeq ($(BOARD_USE_YAMAHA_AUDIO_HAL),true)
  include $(LOCAL_PATH)/../common/ymu828b/ymu828b_product_packages.mk
endif

# Include U-blox LISA product package
ifeq ($(BOARD_USE_UBLOX_LISA_RIL),true)
  include $(LOCAL_PATH)/../common/lisa/lisa_product_packages.mk
endif

# Include Invensense libsensors product package
ifeq ($(BOARD_USE_LEGACY_INVENSENSE),false)
  include $(LOCAL_PATH)/../common/libsensors/libsensors_product_packages.mk
endif

# Include MagicLego modifed Camera HAL
ifeq ($(BOARD_USE_MAGICLEGO_CAMERA_HAL),true)
  include $(LOCAL_PATH)/../common/libcamera/libcamera_product_packages.mk
endif

# Include MagicLego Tools
TOOLS := $(shell find  $(LOCAL_PATH)/../common/tools -name tools_product_package.mk)
ifneq ($(TOOLS), )
  include $(LOCAL_PATH)/../common/tools/tools_product_package.mk
endif
