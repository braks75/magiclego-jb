# Copyright Statement:
#
# This software/firmware and related documentation ("MediaTek Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to MediaTek Inc. and/or its licensors.
# Without the prior written permission of MediaTek inc. and/or its licensors,
# any reproduction, modification, use or disclosure of MediaTek Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.
#
# MediaTek Inc. (C) 2010. All rights reserved.
#
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
# RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
# AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
# AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
# The following software/firmware and/or related documentation ("MediaTek Software")
# have been modified by MediaTek Inc. All revisions are subject to any receiver's
# applicable license agreements with MediaTek Inc.


# Copyright (C) 2008 The Android Open Source Project
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

# Configuration

LOCAL_PATH := $(call my-dir)

SRCS := $(shell find $(LOCAL_PATH)/ -name "*.c")

# applied to MT6620
ifeq ($(BOARD_HAVE_MTK_MT6620),true)
	ifneq ($(SRCS),)
		BUILD_LAUNCHER  := true
		BUILD_WMT_LPBK  := true
	endif
	BUILD_WMT_CFG := true
	BUILD_PATCH := true
	BUILD_WLAN_FW := true
	BUILD_WLAN_MAC_ADDRESS := true
	BUILD_WLAN_5GHZ_BAND := false
endif

ifeq ($(BUILD_LAUNCHER), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := 6620_launcher
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_OUT)/bin
	LOCAL_SRC_FILES := stp_uart_launcher.c
	include $(BUILD_EXECUTABLE)
endif

ifeq ($(BUILD_WMT_LPBK), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := 6620_wmt_lpbk
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_OUT)/bin
	LOCAL_SRC_FILES := wmt_loopback.c
	include $(BUILD_EXECUTABLE)
endif


ifeq ($(BUILD_WMT_CFG), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := WMT.cfg
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/firmware
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)
endif

ifeq ($(BUILD_PATCH), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := mt6620_patch_e3_hdr.bin
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/firmware
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)
endif

ifeq ($(BUILD_PATCH), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := mt6620_patch_e6_hdr.bin
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/firmware
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)
endif

ifeq ($(BUILD_WLAN_FW), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := WIFI_RAM_CODE
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/firmware
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)
endif

ifeq ($(BUILD_WLAN_FW), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := WIFI_RAM_CODE_E6
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/firmware
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)
endif

ifeq ($(BUILD_WLAN_MAC_ADDRESS), true)
	include $(CLEAR_VARS)
	LOCAL_MODULE := WIFI
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/nvram/APCFG/APRDEB
	ifeq ($(BUILD_WLAN_5GHZ_BAND), true)
		LOCAL_SRC_FILES := WIFI_5G
	else
		LOCAL_SRC_FILES := WIFI
	endif
	include $(BUILD_PREBUILT)

	include $(CLEAR_VARS)
	LOCAL_MODULE := WIFI_CUSTOM
	LOCAL_MODULE_TAGS := optional
	LOCAL_MODULE_CLASS := ETC
	LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/nvram/APCFG/APRDEB
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT) 
endif

