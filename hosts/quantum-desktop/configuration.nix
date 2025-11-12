{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../modules ];

  # General
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # User Modules
  common = {
    userName = "quantum";
    shell = pkgs.zsh;
    peripherals = {
      keyboard = "programmer-dvorak";
      monitors = [ "DP-1" "HDMI-A-1" ];
    };
  };

  # System
  networking.hostName = "quantum-desktop";
  networking.networkmanager.enable = true;

  boot.loader = {
    efi = { canTouchEfiVariables = true; };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services.xserver = {
    enable = false; # true breaks the system xD
    xkb = {
      layout = "us";
      variant = "intl";
    };
  };

  environment.systemPackages = with pkgs; [ vim wget git zsh pciutils ];
  system.stateVersion = "25.05";

  # to be moved
  services.getty.autologinUser = config.common.userName;
  programs.firefox.enable = true;
}

