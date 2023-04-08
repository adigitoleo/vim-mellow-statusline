#!/bin/sh
# Run from the project root as ./tools/nvim-test.sh /tools/init.lua

if [ -d "$PWD/.nvimdata_mellowstatusline" ]; then
    echo "Using neovim data from .nvimdata_mellowstatusline."
    echo "Delete that folder to remove package/dependency cache."
fi

export XDG_CONFIG_HOME="$PWD/.nvimdata_mellowstatusline/config"
export XDG_STATE_HOME="$PWD/.nvimdata_mellowstatusline/state"
export XDG_DATA_HOME="$PWD/.nvimdata_mellowstatusline"
nvim -u "$1" "$1"
