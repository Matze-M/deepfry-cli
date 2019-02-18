export OUTPUT_DIR=$(CURDIR)/buildroot/output
export BR_DIR=$(CURDIR)/buildroot
export BR2_EXTERNAL=$(CURDIR)/buildroot_external

PREFIX ?= /usr/local
IMAGES = u-boot-sunxi-with-spl.bin rootfs.cpio.uboot sun5i-r8-chip.dtb zImage boot.scr.bin spl-hynix-mlc.bin spl-toshiba-mlc.bin
LIB_DEST_DIR=$(PREFIX)/lib/deepfry

%_defconfig:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

%:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

nconfig:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) nconfig

install:
	install -m 0755 deepfry $(PREFIX)/bin/deepfry
	mkdir -p $(LIB_DEST_DIR)
	$(foreach img,$(IMAGES), \
		install -m 0755 $(OUTPUT_DIR)/images/$(img) ${LIB_DEST_DIR}/$(img); \
	)

uninstall:
	rm $(PREFIX)/bin/deepfry
	$(foreach img,$(IMAGES), \
		rm ${LIB_DEST_DIR}/$(img); \
	)
