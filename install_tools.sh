#!/usr/bin/env bash

DOTRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
TARBALL_DIR="${DOTRC_ROOT}/tarballs"
TEMP_DIR="${DOTRC_ROOT}/temp_dirs/tarballs"

# prefix.
PREFIX="${HOME}/.local"
export PATH="${HOME}/.local/bin:${PATH}"

# create temp directory.
rm -rf "${TEMP_DIR}"
mkdir -p "${TEMP_DIR}"

# install pip.
${DOTRC_ROOT}/get-pip.py --user

# install cgvg.
install_cgvg() {
    pushd "${TEMP_DIR}"
    git clone https://github.com/uzi/cgvg.git cgvg
    pushd cgvg
    ./configure --prefix="${PREFIX}"
    make -j install
    popd
    rm -rf cgvg
    popd
}

# install vim.
install_vim() {
    pushd "${TEMP_DIR}"
    TARBALL="$(ls -1 ${TARBALL_DIR}/vim-*.tar.gz | head -1)"
    DIR_NAME="$(tar tfz ${TARBALL} | head -1 | cut -f1 -d"/")"
    tar xfz ${TARBALL}
    pushd ${DIR_NAME}
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --enable-luainterp=yes \
        --enable-cscope \
        --prefix="${PREFIX}"
    make -j install
    popd
    rm -rf ${DIR_NAME}
    popd
}

# install libevent.
install_libevent() {
    pushd "${TEMP_DIR}"
    TARBALL="$(ls -1 ${TARBALL_DIR}/libevent-*.tar.gz | head -1)"
    DIR_NAME="$(tar tfz ${TARBALL} | head -1 | cut -f1 -d"/")"
    tar xfz ${TARBALL}
    pushd ${DIR_NAME}
    ./configure --prefix="${PREFIX}"
    make -j install
    popd
    rm -rf ${DIR_NAME}
    popd
}

# install tmux.
install_tmux() {
    pushd "${TEMP_DIR}"
    TARBALL="$(ls -1 ${TARBALL_DIR}/tmux-*.tar.gz | head -1)"
    DIR_NAME="$(tar tfz ${TARBALL} | head -1 | cut -f1 -d"/")"
    tar xfz ${TARBALL}
    pushd ${DIR_NAME}
    export CFLAGS="-I${PREFIX}/include"
    export LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib"
    ./configure --prefix="${PREFIX}"
    make -j install
    popd
    rm -rf ${DIR_NAME}
    popd
}

# install powerline.
install_powerline() {
    pushd "${TEMP_DIR}"
    TARBALL="$(ls -1 ${TARBALL_DIR}/powerline-*.tar.gz | head -1)"
    DIR_NAME="$(tar tfz ${TARBALL} | head -1 | cut -f1 -d"/")"
    tar xfz ${TARBALL}
    pushd ${DIR_NAME}
    python setup.py install --user
    popd
    rm -rf ${DIR_NAME}
    popd
}

install_cgvg
install_vim
install_libevent
install_tmux
install_powerline
