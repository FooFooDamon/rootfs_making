#!/bin/sh

# SPDX-License-Identifier: GPL-2.0

#
# Startup script of login shell.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

echo "Shell: $SHELL"

alias ll='ls -alF'

export PS1='[\u@\h:\W]# '

for i in ifconfig ping ssh scp
do
	which $i > /dev/null || echo "*** Command not found: $i" >&2
done
which wget > /dev/null || which curl > /dev/null || echo "*** Neither wget nor curl command was found!" >&2
[ -z "$(which vim)" ] && [ -n "$(which vi)" ] && alias vim=vi || :

for i in poweroff halt shutdown reboot
do
	alias ${i}="echo '*** ${i}: DANGEROUS!!! Specify the full path of this command if you really need to run it.'"
done

# Private or specific settings can be put in this file.
[ -f ${HOME}/.bashrc.devel ] && source ${HOME}/.bashrc.devel || :

