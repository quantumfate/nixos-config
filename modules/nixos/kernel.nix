# TODO: Make zen kerne host dependent

{ pkgs, ... }: { boot.kernelPackages = pkgs.linuxPackages_zen; }
