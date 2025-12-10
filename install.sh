#!/usr/bin/env bash

ADDITIONAL_FLAGS=${2:""}
cd "$HOME/nixos-config" || exit 1

if [[ "$1" == "--upgrade" || "$1" == "-u" ]]; then
    pkill zen-twilight
    sudo nixos-rebuild switch --upgrade $ADDITIONAL_FLAGS --flake "$HOME/nixos-config#quantum-desktop"
elif [[ "$1" == "--rebuild" || "$1" == "-r" ]]; then
    pkill zen-twilight
    sudo nixos-rebuild switch --flake $ADDITIONAL_FLAGS "$HOME/nixos-config#quantum-desktop"
elif [[ "$1" == "--flake-update" || "$1" == "-f" ]]; then
    nix flake update
    git add $HOME/nixos-config
    git commit -m "Nix Flake Update"
    git push
    pkill zen-twilight
    sudo nixos-rebuild switch --flake $ADDITIONAL_FLAGS "$HOME/nixos-config#quantum-desktop"
else
	echo "usage: ./install.sh [-u | --upgrade] [-r | --rebuild] [-f | --flake-update ] [<args passed to nixos-rebuild switch>]"
fi
