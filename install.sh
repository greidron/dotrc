#!/usr/bin/env bash
set -e

DOTRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# install vimrc.
$DOTRC_ROOT/install_vimrc.sh
# install tmux.
$DOTRC_ROOT/install_tmux.sh
