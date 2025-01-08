ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

OMXCORE_CFLAGS := -g -O3 -DVERBOSE
OMXCORE_CFLAGS += -O0 -fno-inline -fno-short-enums
OMXCORE_CFLAGS += -D_ANDROID_
OMXCORE_CFLAGS += -U_ENABLE_QC_MSG_LOG_
OMXCORE_CFLAGS += -Wno-error

#===============================================================================
#             LIBRARY for Android apps
#===============================================================================

LOCAL_C_INCLUDES        := $(LOCAL_PATH)/src/common
LOCAL_C_INCLUDES        += $(LOCAL_PATH)/inc
LOCAL_PRELINK_MODULE    := false
LOCAL_MODULE            := libOmxCore
LOCAL_LICENSE_KINDS     := SPDX-license-identifier-BSD SPDX-license-identifier-MIT
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_NOTICE_FILE       := $(LOCAL_PATH)/../NOTICE
LOCAL_MODULE_TAGS       := optional
LOCAL_PROPRIETARY_MODULE:= true
LOCAL_SHARED_LIBRARIES  := liblog libdl libcutils
LOCAL_CFLAGS            := $(OMXCORE_CFLAGS)

LOCAL_SRC_FILES         := src/common/omx_core_cmp.cpp
LOCAL_SRC_FILES         += src/common/qc_omx_core.c
LOCAL_SRC_FILES         += src/msm8996/registry_table_android.c

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := OmxCore_headers
LOCAL_LICENSE_KINDS := SPDX-license-identifier-BSD SPDX-license-identifier-MIT
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_NOTICE_FILE := $(LOCAL_PATH)/../NOTICE
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/inc
include $(BUILD_HEADER_LIBRARY)

#===============================================================================
#             LIBRARY for command line test apps
#===============================================================================

include $(CLEAR_VARS)

LOCAL_C_INCLUDES        := $(LOCAL_PATH)/src/common
LOCAL_C_INCLUDES        += $(LOCAL_PATH)/inc
LOCAL_PRELINK_MODULE    := false
LOCAL_MODULE            := libmm-omxcore
LOCAL_LICENSE_KINDS     := SPDX-license-identifier-BSD SPDX-license-identifier-MIT
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_NOTICE_FILE       := $(LOCAL_PATH)/../NOTICE
LOCAL_MODULE_TAGS       := optional
LOCAL_PROPRIETARY_MODULE:= true
LOCAL_SHARED_LIBRARIES  := liblog libdl libcutils
LOCAL_CFLAGS            := $(OMXCORE_CFLAGS)

LOCAL_SRC_FILES         := src/common/omx_core_cmp.cpp
LOCAL_SRC_FILES         += src/common/qc_omx_core.c
LOCAL_SRC_FILES         += src/msm8996/registry_table.c

include $(BUILD_SHARED_LIBRARY)

endif #BUILD_TINY_ANDROID
