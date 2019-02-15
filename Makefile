export OUTPUT_DIR=$(CURDIR)/buildroot/output
export BR_DIR=$(CURDIR)/buildroot
export BR2_EXTERNAL=$(CURDIR)/buildroot_external

%_defconfig:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

%:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

nconfig:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) nconfig
