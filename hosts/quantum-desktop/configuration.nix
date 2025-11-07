{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../modules ];

  # General
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # User Modules
  main-user.enable = true;
  main-user.userName = "quantum"; 

  userPrograms.zsh.enable = true;

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
  services.udisks2.enable = true;
  services.getty.autologinUser = config.main-user.userName;
  programs.firefox.enable = true;
}

