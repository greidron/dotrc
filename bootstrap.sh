#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# get pacapt
curl -sL https://github.com/icy/pacapt/raw/ng/pacapt -o ${SCRIPT_DIR}/pacapt
# install packages.
PACKAGES="cmake make gcc python-devel python-dev ncurses-devel ncurses-dev git tig"
for PACKAGE in $PACKAGES; do
    ${SHELL} ${SCRIPT_DIR}/pacapt install --noconfirm ${PACKAGE}
done
rm -f ${SCRIPT_DIR}/pacapt
