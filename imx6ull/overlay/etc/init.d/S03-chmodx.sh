#!/bin/sh

# SPDX-License-Identifier: GPL-2.0

#
# Assign execute permission to user scripts.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

chmodx()
{
    for user_script in /etc/init.d/S??-* /usr/bin/update_*.sh /usr/bin/mount_*_dir*
    do
        [ -x ${user_script} ] || chmod +x ${user_script}
    done
}

do_nothing()
{
    :
}

case "$1" in
  start)
    chmodx
    ;;
  stop)
    do_nothing
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
esac

