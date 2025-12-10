#!/usr/bin/env bash

ADDITIONAL_FLAGS=${$ADDITIONAL_FLAGS:-""}

if [[ "$1" == "--upgrade" || "$1" == "-u" ]]; then
    pkill zen-twilight
    sudo nixos-rebuild switch --upgrade $ADDITIONAL_FLAGS --flake "$HOME/nixos-config#quantum-desktop"
elif [[ "$1" == "--rebuild" || "$1" == "-r" ]]; then
    pkill zen-twilight
    sudo nixos-rebuild switch --flake $ADDITIONAL_FLAGS "$HOME/nixos-config#quantum-desktop"
else
	echo "usage: ./install.sh [-u | --upgrade] [-r | --rebuild] [<args passed to nixos-rebuild switch>]"
fi
