# SPDX-License-Identifier: GPL-2.0

#
# Makefile wrapper for Buildroot.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

ifeq ($(shell [ -s __ver__.mk -a -s buildroot.mk ] && echo 1 || echo 0),0)

LAZY_CODING_URL ?= https://github.com/FooFooDamon/lazy_coding_skills

.PHONY: all help init

all help init:
	@for i in __ver__.mk u-boot.mk; \
	do \
		[ -s $${i} ] || wget -c "${LAZY_CODING_URL}/raw/main/makefile/$${i}"; \
	done
	@echo "~ ~ ~ Initialization finished successfully ~ ~ ~"
	@echo "Re-run your command again to continue your work."

else

include __ver__.mk

PKG_VERSION ?= 2023.02
SRC_PARENT_DIR ?= ${HOME}/src
INSTALL_DIR ?= ${HOME}/tftpd/imx6ullevk
BUSYBOX_CONFIG := package/busybox/busybox.config
CUSTOM_DIR ?= custom
CUSTOM_FILES ?= ${BUSYBOX_CONFIG} \
    package/busybox/0005-libbb-printable_string2.patch \
    package/busybox/0006-libbb-unicode_conv_to_printable2.patch

include buildroot.mk

endif

