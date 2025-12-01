{ config, ... }:

let userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    # https://mynixos.com/options/programs.rofi
    programs.rofi = {
      enable = true;
      terminal = "/etc/profiles/per-user/${userCfg.name}/bin/foot";
      font = "${config.common.style.fontFamily} 16";
      cycle = true;
      location = "center";
      modes = [ "run" "drun" "window" ];
      extraConfig = {
        icon-theme = "Papirus-dark";
        drun-display-format = "{icon} {name}";
        lines = 5;
        hide-scrollbar = true;
        display-drun = " Apps ";
        display-run = " Run ";
        display-window = " Window ";
        sidebar-mode = true;
        sorting-method = "fzf";
        disable-history = true;
        show-icons = true;
      };
    };
  };
}
