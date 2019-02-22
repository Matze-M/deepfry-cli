export OUTPUT_DIR=$(CURDIR)/buildroot/output
export BR_DIR=$(CURDIR)/buildroot
export BR2_EXTERNAL=$(CURDIR)/buildroot_external
export VERSION=$(shell cat $(CURDIR)/version)

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
	mkdir -p $(PREFIX)/bin
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

deb:
	$(eval TMP := $(shell mktemp -d))
	$(eval DST := $(TMP)/deepfry-cli)
	mkdir -p $(DST)/DEBIAN
	sed -e 's/##VERSION##/'$(VERSION)'/g' DEBIAN/control >$(DST)/DEBIAN/control
	PREFIX=$(DST) make install
	dpkg-deb --build $(DST)
	cp $(DST).deb $(CURDIR)
	rm -rf $(TMP)
