{ config, ... }:

let userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    # https://mynixos.com/options/programs.rofi
    programs.rofi = {
      enable = true;
      terminal = "/etc/profiles/per-user/${userCfg.name}/bin/foot";
      font = "${config.common.style.fontFamily}";
      cycle = true;
      location = "center";
      modes = [ "run" "drun" "window" ];
    };
  };
}
