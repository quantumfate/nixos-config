{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../modules/nixos ];

  nixpkgs.config.allowUnfree = true;

  main-user.enable = true;
  main-user.userName = "quantum";

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = "quantum-desktop";
  networking.networkmanager.enable =
    true;

  time.timeZone = "Europe/Berlin";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
  services.getty.autologinUser = "quantum";

  services.udisks2.enable = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    zsh
    pciutils
  ];
  
  environment.pathsToLink = [
    "/share/zsh"
  ];

  system.stateVersion = "25.05";

}

