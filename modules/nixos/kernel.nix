{ config, pkgs, ... }:

let
  hostKernelMap = {
    "quantum-desktop" = pkgs.linuxPackages_zen;
    "quantum-laptop" = pkgs.linuxPackages_xanmod;
    "default" = pkgs.linuxPackages_latest;
  };
in {
  boot.kernelPackages =
    hostKernelMap.${config.networking.hostName} or hostKernelMap.default;
}
