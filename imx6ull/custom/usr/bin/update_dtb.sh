#!/bin/sh

# SPDX-License-Identifier: GPL-2.0

#
# Update device tree based on MTD mechanism and NAND flash tools.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

update_dtb()
{
    local mtd_part=$(cat /proc/mtd | grep -i "dtb" | awk -F : '{ print $1 }')
    local dtb_path="$1"

    [ -n "${mtd_part}" ] || echo "*** Can not find MTD partition info!" >&2
    [ -n "${dtb_path}" -a -f ${dtb_path} ] || echo "*** Unspecified or non-existent *.dtb file: ${dtb_path}!" >&2

    if [ $(echo "${dtb_path}" | grep -c '\.dtb$') -gt 0 -a -f ${dtb_path} ]; then
        flash_erase /dev/${mtd_part} 0 0 && nandwrite -p /dev/${mtd_part} -p ${dtb_path} && sync || return $?
    else
        return 1
    fi
}

update_dtb $*

