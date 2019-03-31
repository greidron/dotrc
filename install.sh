#!/usr/bin/env bash
set -e

DOTRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

case $1 in
    tools)
        $DOTRC_ROOT/install_tools.sh
        ;;
    vimrc)
        $DOTRC_ROOT/install_vimrc.sh
        ;;
    tmux)
        $DOTRC_ROOT/install_tmux.sh
        ;;
    *)
        $DOTRC_ROOT/install_tools.sh
        $DOTRC_ROOT/install_vimrc.sh
        $DOTRC_ROOT/install_tmux.sh
        ;;
esac
