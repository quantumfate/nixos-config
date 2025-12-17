{ pkgs, config, lib, ... }:

let
  cfg = config.common;

  monitorXsessionMap = {
    DP-1 = "DP-0";
    HDMI-A-1 = "HDMI-0";
    eDP-1 = "eDP-0";
  };
  buildCommands = monitors:
    lib.strings.concatMapStrings (monitor:
      if monitor == cfg.peripherals.primaryMonitor.name then ''
        /run/current-system/sw/bin/xrandr --output ${
          monitorXsessionMap.${monitor}
        } --primary --auto
      '' else ''
        /run/current-system/sw/bin/xrandr --output ${
          monitorXsessionMap.${monitor}
        } --off
      '') monitors;

  catppuccinCfg = config.common.style.catppuccin;
in {
  environment.systemPackages = with pkgs; [ xorg.xrandr ];

  catppuccin.sddm = {
    flavor = catppuccinCfg.flavor;
    font = config.common.style.guiFont;
    background = "${../../assets/wallpapers/anime-girl.jpg}";
    fontSize = "12";
    loginBackground = false;
  };

  services = {
    xserver = {
      enable = true;
      displayManager = {
        setupCommands = buildCommands cfg.peripherals.monitors;
      };
    };
    displayManager = {
      defaultSession = "hyprland";

      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        enableHidpi = true;
      };
    };
  };
}
