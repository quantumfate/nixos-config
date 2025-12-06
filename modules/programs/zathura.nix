{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    programs.zathura = {
      enable = true;
      automount = true;
      options = {
        sandbox = "none";
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 1;
        selection-clipboard = "clipboard";
        incremental-search = true;
        font = "${config.common.style.fontFamily} 12";
      };
      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode";
        r = "reload";
        R = "rotate";
        K = "zoom in";
        J = "zoom out";
        i = "recolor";
        p = "print";
        g = "goto top";
        "<C-j>" = "navigate_index down";
        "<C-k>" = "navigate_index up";
      };
    };
  };
}
