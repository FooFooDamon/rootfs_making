#!/bin/sh

# SPDX-License-Identifier: GPL-2.0

#
# Update U-Boot based on MTD mechanism and NAND flash tools.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

update_uboot()
{
    local mtd_part=$(cat /proc/mtd | grep -i "boot" | awk -F : '{ print $1 }' | head -n 1)
    local uboot_path="$1"

    [ -n "${mtd_part}" ] || echo "*** Can not find MTD partition info!" >&2
    [ -n "${uboot_path}" -a -f ${uboot_path} ] || echo "*** Unspecified or non-existent u-boot.imx file: ${uboot_path}!" >&2

    if [ $(echo "${uboot_path}" | grep -c 'u-boot\.imx$') -gt 0 -a -f ${uboot_path} ]; then
        set -x

        mount -t debugfs debugfs /sys/kernel/debug \
            && flash_erase /dev/${mtd_part} 0 0 \
            && kobs-ng init -x -v --chip_0_device_path=/dev/${mtd_part} ${uboot_path} \
            && sync

        set +x
    else
        return 1
    fi
}

update_uboot $*

