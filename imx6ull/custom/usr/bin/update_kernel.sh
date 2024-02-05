#!/bin/sh

# SPDX-License-Identifier: GPL-2.0

#
# Update kernel image based on MTD mechanism and NAND flash tools.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

update_kernel()
{
    local img_path="$1"

    if [ -z "${img_path}" -o ! -f ${img_path} ]; then
        echo "*** Unspecified or non-existent kernel image: ${img_path}!" >&2
        return 1
    fi

    for i in $(cat /proc/mtd | grep -i "kernel" | awk -F : '{ print $1 }')
    do
        if [ $(echo "${img_path}" | grep -c 'zImage$') -gt 0 -a -f ${img_path} ]; then
            flash_erase /dev/${i} 0 0 && nandwrite -p /dev/${i} -p ${img_path} && sync || return $?
        else
            return 1
        fi
    done
    unset i
}

update_kernel $*

