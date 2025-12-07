{ config, pkgs, ... }:

{
  # https://github.com/ThePrimeagen/keyboards
  # https://www.reddit.com/r/NixOS/comments/1lf67uq/creating_a_custom_keyboard_layout_in_nix/ 
  config = {
    environment.systemPackages = with pkgs; [ qmk dos2unix ];
    hardware.keyboard.qmk.enable = true;

    console = {
      useXkbConfig = true; # use xkbOptions in tty.
    };

    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "dvp";
    };
  };
}
