################################################################################
#
# mtd
#
################################################################################

CHIP_MTD_UTILS_VERSION = f6a16e575091ef315b147532ba818877fd2c1895
CHIP_MTD_UTILS_SITE = $(call github,kaplan2539,chip-mtd-utils,$(CHIP_MTD_UTILS_VERSION))
CHIP_MTD_UTILS_LICENSE = GPLv2
CHIP_MTD_UTILS_LICENSE_FILES = COPYING

CHIP_MTD_UTILS_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_CHIP_MTD_UTILS_MKFSJFFS2),y)
CHIP_MTD_UTILS_DEPENDENCIES = zlib lzo
endif

ifeq ($(BR2_PACKAGE_CHIP_MTD_UTILS_MKFSUBIFS),y)
CHIP_MTD_UTILS_DEPENDENCIES += util-linux zlib lzo host-pkgconf
define CHIP_MTD_UTILS_ADD_MISSING_LINTL
	$(SED) "/^LDLIBS_mkfs\.ubifs/ s%$$% `$(PKG_CONFIG_HOST_BINARY) --libs uuid`%" \
		$(@D)/Makefile
endef
CHIP_MTD_UTILS_POST_PATCH_HOOKS += CHIP_MTD_UTILS_ADD_MISSING_LINTL
endif

ifeq ($(BR2_PACKAGE_BUSYBOX),y)
CHIP_MTD_UTILS_DEPENDENCIES += busybox
endif

# If extended attributes are required, the acl package must
# also be enabled which will also include the attr package.
ifeq ($(BR2_PACKAGE_ACL),y)
CHIP_MTD_UTILS_DEPENDENCIES += acl
CHIP_MTD_UTILS_MAKE_OPTS += WITHOUT_XATTR=0
else
CHIP_MTD_UTILS_MAKE_OPTS += WITHOUT_XATTR=1
endif

HOST_CHIP_MTD_UTILS_DEPENDENCIES = host-zlib host-lzo host-e2fsprogs

define HOST_CHIP_MTD_UTILS_BUILD_CMDS
	$(HOST_CONFIGURE_OPTS) $(MAKE1) \
		CROSS= BUILDDIR=$(@D) WITHOUT_XATTR=1 -C $(@D)
endef

define HOST_CHIP_MTD_UTILS_INSTALL_CMDS
	$(MAKE1) BUILDDIR=$(@D) DESTDIR=$(HOST_DIR) -C $(@D) install
endef

MKFS_JFFS2 = $(HOST_DIR)/usr/sbin/mkfs.jffs2
SUMTOOL = $(HOST_DIR)/usr/sbin/sumtool

CHIP_MTD_UTILS_STAGING_y = lib/libmtd.a ubi-utils/libubi.a
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_DOCFDISK)		+= docfdisk
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_DOC_LOADBIOS)	+= doc_loadbios
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASHCP)		+= flashcp
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASH_ERASE)	+= flash_erase
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASH_LOCK)	+= flash_lock
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASH_OTP_DUMP)	+= flash_otp_dump
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASH_OTP_INFO)	+= flash_otp_info
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASH_OTP_LOCK)	+= flash_otp_lock
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASH_OTP_WRITE)	+= flash_otp_write
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FLASH_UNLOCK)	+= flash_unlock
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FTL_CHECK)	+= ftl_check
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_FTL_FORMAT)	+= ftl_format
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_JFFS2DUMP)	+= jffs2dump
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_MKFSJFFS2)	+= mkfs.jffs2
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_MTD_DEBUG)	+= mtd_debug
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_MTDPART)		+= mtdpart
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_NANDDUMP)		+= nanddump
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_NANDTEST)		+= nandtest
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_NANDWRITE)	+= nandwrite
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_NFTLDUMP)		+= nftldump
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_NFTL_FORMAT)	+= nftl_format
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_RECV_IMAGE)	+= recv_image
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_RFDDUMP)		+= rfddump
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_RFDFORMAT)	+= rfdformat
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_SERVE_IMAGE)	+= serve_image
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_SUMTOOL)		+= sumtool

CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_MTDINFO)	+= mtdinfo
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIATTACH)	+= ubiattach
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBICRC32)	+= ubicrc32
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIDETACH)	+= ubidetach
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIFORMAT)	+= ubiformat
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIMKVOL)	+= ubimkvol
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBINFO)	+= ubinfo
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBINIZE)	+= ubinize
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIRENAME)	+= ubirename
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIRMVOL)	+= ubirmvol
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIRSVOL)	+= ubirsvol
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIUPDATEVOL)	+= ubiupdatevol
CHIP_MTD_UTILS_TARGETS_UBI_$(BR2_PACKAGE_CHIP_MTD_UTILS_UBIBLOCK)	+= ubiblock

CHIP_MTD_UTILS_TARGETS_y += $(addprefix ubi-utils/,$(CHIP_MTD_UTILS_TARGETS_UBI_y))
CHIP_MTD_UTILS_TARGETS_$(BR2_PACKAGE_CHIP_MTD_UTILS_MKFSUBIFS) += mkfs.ubifs/mkfs.ubifs

ifeq ($(BR2_PACKAGE_CHIP_MTD_UTILS_INTEGCK),y)
define CHIP_MTD_UTILS_BUILD_INTEGCK
	$(TARGET_CONFIGURE_OPTS) $(MAKE1) CROSS=$(TARGET_CROSS) \
		BUILDDIR=$(@D) $(CHIP_MTD_UTILS_MAKE_OPTS) -C $(@D)/tests/fs-tests all
endef
define CHIP_MTD_UTILS_INSTALL_INTEGCK
	$(INSTALL) -D -m 755 $(@D)/tests/fs-tests/integrity/integck $(TARGET_DIR)/usr/sbin/integck
endef
endif

define CHIP_MTD_UTILS_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE1) CROSS=$(TARGET_CROSS) \
		BUILDDIR=$(@D) $(CHIP_MTD_UTILS_MAKE_OPTS) -C $(@D) \
		$(addprefix $(@D)/,$(CHIP_MTD_UTILS_TARGETS_y)) \
		$(addprefix $(@D)/,$(CHIP_MTD_UTILS_STAGING_y))
	$(MTD_BUILD_INTEGCK)
endef

define CHIP_MTD_UTILS_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lib/libmtd.a $(STAGING_DIR)/usr/lib/libmtd.a
	$(INSTALL) -D -m 0755 $(@D)/ubi-utils/libubi.a $(STAGING_DIR)/usr/lib/libubi.a
	$(INSTALL) -D -m 0644 $(@D)/include/libmtd.h $(STAGING_DIR)/usr/include/mtd/libmtd.h
	$(INSTALL) -D -m 0644 $(@D)/ubi-utils/include/libubi.h $(STAGING_DIR)/usr/include/mtd/libubi.h
	$(INSTALL) -D -m 0644 $(@D)/include/mtd/ubi-media.h $(STAGING_DIR)/usr/include/mtd/ubi-media.h
endef

define CHIP_MTD_UTILS_INSTALL_TARGET_CMDS
	for f in $(CHIP_MTD_UTILS_TARGETS_y) ; do \
		$(INSTALL) -D -m 0755 $(@D)/$$f $(TARGET_DIR)/usr/sbin/$${f##*/} ; \
	done
	$(CHIP_MTD_UTILS_INSTALL_INTEGCK)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
