#!/usr/bin/env bash
set -e

DOTRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "set runtimepath+=$DOTRC_ROOT

source $DOTRC_ROOT/vimrcs/basic.vim
source $DOTRC_ROOT/vimrcs/filetypes.vim
source $DOTRC_ROOT/vimrcs/plugins_config.vim
source $DOTRC_ROOT/vimrcs/extended.vim

try
source $DOTRC_ROOT/my_configs.vim
catch
endtry" > ~/.vimrc

echo "Installed vimrc ;)"
