{ config, lib, ... }:
let cfg = config.userPrograms.rofi;
in {
  options.userPrograms.rofi.enable = lib.mkEnableOption "Rofi configuration.";
  imports = lib.mkIf cfg.enable [ ./main.nix ];
}
