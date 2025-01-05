ifeq ($(call my-dir),$(call project-path-for,qcom-media))

QCOM_MEDIA_ROOT := $(call my-dir)

ifeq ($(call is-board-platform-in-list, $(MSM_VIDC_TARGET_LIST)),true)
include $(QCOM_MEDIA_ROOT)/libarbitrarybytes/Android.mk
endif

endif
