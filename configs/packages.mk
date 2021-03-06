ifeq ($(TARGET_LUNA_PLATFORM_SDK_APPS),true)
PRODUCT_PACKAGES += \
    Bolt \
    MusicX
endif

# Required packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CellBroadcastReceiver \
    LatinIME \
    LiveWallpapersPicker \
    messaging

# Optional packages
PRODUCT_PACKAGES += \
    Terminal \
    PhotoTable

# AOSCP Packages
PRODUCT_PACKAGES += \
    GalleryX \
    LunaQuickStep \
    MiServices

# AOSCP Hardware
PRODUCT_PACKAGES += \
    hardware.aoscp.core \
	hardware.aoscp.core.xml \
    hardware.aoscp.controllers \
    hardware.aoscp.controllers.xml

# MiServices Permissions
PRODUCT_COPY_FILES += \
    vendor/aoscp/prebuilt/common/etc/default-permissions/co.aoscp.miservices.xml:system/etc/default-permissions/co.aoscp.miservices.xml

# Aoscp OTA
PRODUCT_PACKAGES += COTA

# Google Packages
PRODUCT_PACKAGES += \
    MarkupGoogle \
    SoundPickerPrebuilt \
    Wallpapers

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/aoscp/prebuilt/common/lib/libsketchology_native.so:system/lib/libsketchology_native.so \
    vendor/aoscp/prebuilt/common/lib64/libsketchology_native.so:system/lib64/libsketchology_native.so

# Turbo
PRODUCT_PACKAGES += \
    Turbo \
    turbo.xml \
    privapp-permissions-turbo.xml

# ActionServices
PRODUCT_PACKAGES += \
    MatchmakerPrebuilt \
    privapp-permissions-actionservices.xml

# Extra tools
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    tune2fs \
    nano \
    htop \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    pigz \
    7z \
    lib7z \
    bash \
    bzip2 \
    curl \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PACKAGES += \
    procmem \
    procrank
