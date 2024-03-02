#!/bin/sh

# SPDX-License-Identifier: GPL-2.0

#
# Set time zone.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

#
# Modify the time zone info below according to your need.
#

set_timezone()
{
    local wr=$(which wr)

    if [ "$(cat /etc/timezone)" != "Asia/Shanghai" ]; then
        echo Asia/Shanghai | ${wr} tee /etc/timezone
    fi

    if [ "$(basename $(ls -l /etc/localtime | awk '{ print $NF }'))" != "Shanghai" ]; then
        ${wr} ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    fi
}

case "$1" in
  start)
    set_timezone
    ;;
  stop)
    :
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
esac

