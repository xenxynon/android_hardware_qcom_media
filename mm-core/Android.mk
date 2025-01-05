ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

OMXCORE_CFLAGS := -g -O3 -DVERBOSE
OMXCORE_CFLAGS += -O0 -fno-inline -fno-short-enums
OMXCORE_CFLAGS += -D_ANDROID_
OMXCORE_CFLAGS += -U_ENABLE_QC_MSG_LOG_

#===============================================================================
#             Figure out the targets
#===============================================================================

ifeq ($(filter $(TARGET_BOARD_PLATFORM), msmnile),$(TARGET_BOARD_PLATFORM))
OMXCORE_CFLAGS += -D_NILE_
else ifeq ($(filter $(TARGET_BOARD_PLATFORM), $(MSMSTEPPE)),$(TARGET_BOARD_PLATFORM))
OMXCORE_CFLAGS += -D_STEPPE_
else ifeq ($(filter $(TARGET_BOARD_PLATFORM), $(TRINKET)),$(TARGET_BOARD_PLATFORM))
OMXCORE_CFLAGS += -D_TRINKET_
else ifeq ($(filter $(TARGET_BOARD_PLATFORM), atoll),$(TARGET_BOARD_PLATFORM))
OMXCORE_CFLAGS += -D_ATOLL_
endif

#===============================================================================
#             LIBRARY for Android apps
#===============================================================================

LOCAL_C_INCLUDES        := $(LOCAL_PATH)/src/common
LOCAL_C_INCLUDES        += $(call project-path-for,qcom-media)/libplatformconfig

LOCAL_HEADER_LIBRARIES := \
        libutils_headers \
        libomxcore_headers

LOCAL_EXPORT_HEADER_LIBRARY_HEADERS := libomxcore_headers

LOCAL_PRELINK_MODULE    := false
LOCAL_MODULE            := libOmxCore
LOCAL_MODULE_TAGS       := optional
LOCAL_VENDOR_MODULE     := true
LOCAL_SHARED_LIBRARIES  := liblog libdl libcutils
LOCAL_SHARED_LIBRARIES  += libplatformconfig
LOCAL_CFLAGS            := $(OMXCORE_CFLAGS)

LOCAL_SRC_FILES         := src/common/omx_core_cmp.cpp
LOCAL_SRC_FILES         += src/common/qc_omx_core.c
LOCAL_SRC_FILES         += src/registry_table_android.c

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := libomxcore_headers
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/inc
LOCAL_VENDOR_MODULE := true

include $(BUILD_HEADER_LIBRARY)

endif #BUILD_TINY_ANDROID
