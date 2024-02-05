#!/bin/sh

# SPDX-License-Identifier: GPL-2.0

#
# Mount a remote host directory for development convenience.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

mount_development_directory()
{
    if [ $(echo ${DEVEL_HOST_IP} | grep -c '^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+$') -gt 0 ]; then
        ping -c 1 -W 1 ${DEVEL_HOST_IP} || return $?
    else
        echo "*** Invalid or undefined DEVEL_HOST_IP environment variable value: ${DEVEL_HOST_IP}" >&2
        return 1
    fi

    if [ -z "${DEVEL_HOST_DIR}" ]; then
        echo "*** DEVEL_HOST_DIR environment variable not defined!" >&2
        return 1
    fi

    mount -t nfs -o nolock,soft ${DEVEL_HOST_IP}:${DEVEL_HOST_DIR} /mnt
}

mount_development_directory $*

