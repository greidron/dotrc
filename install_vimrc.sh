#!/usr/bin/env bash
set -e

DOTRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# initialize submodules.
if [ -d "$DOTRC_ROOT/.git" ]; then
    git submodule update --init --recursive
fi

# install plugins.
for lPluginDir in ls -d -1 $DOTRC_ROOT/sources_*/*; do
    if [ -f "$lPluginDir/setup.py" ]; then
        python "$lPluginDir/setup.py" install --user
    elif [ -f "$lPluginDir/install.py" ]; then
        python "$lPluginDir/install.py"
    elif [ -f "$lPluginDir/install.sh" ]; then
        sh "$lPluginDir/install.sh"
    fi
done

# write vimrc.
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
