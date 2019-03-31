#!/usr/bin/env bash

DOTRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# install packages.
PACKAGES="cmake make gcc python-devel python-dev ncurses-devel ncurses-dev git tig"
for PACKAGE in $PACKAGES; do
    ${DOTRC_ROOT}/pacapt install --noconfirm ${PACKAGE}
done
