#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# get pacapt
wget https://github.com/icy/pacapt/raw/ng/pacapt -O ${SCRIPT_DIR}/pacapt
chmod +x ${SCRIPT_DIR}/pacapt
# install packages.
PACKAGES="cmake make gcc python-devel python-dev ncurses-devel ncurses-dev git tig"
for PACKAGE in $PACKAGES; do
    ${SCRIPT_DIR}/pacapt install --noconfirm ${PACKAGE}
done
rm -f ${SCRIPT_DIR}/pacapt
