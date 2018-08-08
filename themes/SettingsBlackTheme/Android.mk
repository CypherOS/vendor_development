LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_RRO_THEME := SettingsBlackTheme
LOCAL_CERTIFICATE := platform
LOCAL_SDK_VERSION := current

LOCAL_SRC_FILES := $(call all-subdir-java-files)

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res

LOCAL_PACKAGE_NAME := SettingsBlackTheme

include $(BUILD_RRO_PACKAGE)