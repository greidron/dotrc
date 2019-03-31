#!/usr/bin/env bash
set -e

DOTRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# install .tmux.conf
sed "s|@DOTRC_ROOT@|$DOTRC_ROOT|g" $DOTRC_ROOT/tmux/tmux.conf > ~/.tmux.conf

# bootstraping.
tmux new "echo 'bootstrapping tmux ...' && tmux source ~/.tmux.conf"

# install plugins.
~/.tmux/plugins/tpm/bin/install_plugins

echo "Installed tmux ;)"
