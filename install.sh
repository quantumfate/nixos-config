#!/usr/bin/env bash

# Not used for installation from a live image

ADDITIONAL_FLAGS=${2:""}
cd "$HOME/Projects/github/nixos-config" || exit 1
HOST=$(hostname)

if [[ "$1" == "--upgrade" || "$1" == "-u" ]]; then
    pkill zen-twilight
    sudo nixos-rebuild switch --upgrade $ADDITIONAL_FLAGS --flake "$HOME/Projects/github/nixos-config#$HOST"
elif [[ "$1" == "--rebuild" || "$1" == "-r" ]]; then
    pkill zen-twilight
    sudo nixos-rebuild switch $ADDITIONAL_FLAGS --flake "$HOME/Projects/github/nixos-config#$HOST"
elif [[ "$1" == "--flake-update" || "$1" == "-f" ]]; then
    nix flake update
    git add $HOME/Projects/github/nixos-config
    git commit -m "Nix Flake Update"
    git push
    pkill zen-twilight
    sudo nixos-rebuild switch --upgrade $ADDITIONAL_FLAGS --flake "$HOME/Projects/github/nixos-config#$HOST"
else
	echo "usage: ./install.sh [-u | --upgrade] [-r | --rebuild] [-f | --flake-update ] [<args passed to nixos-rebuild switch>]"
fi
