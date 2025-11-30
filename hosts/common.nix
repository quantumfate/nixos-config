{ config, pkgs, ... }:

let cfg = config.common;
in {
  imports = [ ../modules ];

  # General
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System
  networking.hostName = cfg.hostName;
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

  time.timeZone = cfg.timeZone;
  i18n.defaultLocale = cfg.defaultLocale;

  console = {
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services.xserver = {
    xkb = {
      layout = cfg.keyboard.layout;
      variant = cfg.keyboard.variant;
    };
  };

  users.users.${cfg.user.name} = {
    isNormalUser = true;
    extraGroups = cfg.user.groups ++ [ "wheel" "networkmanager" ];
    description = "main user";
    shell = cfg.user.shell;
  };

  environment.systemPackages = with pkgs; [ vim wget git zsh pciutils ];
  system.stateVersion = "25.05";
}
