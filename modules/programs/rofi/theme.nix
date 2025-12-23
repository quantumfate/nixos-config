{ config, lib, ... }:

let
  userCfg = config.common.user;
  border_radius = 0;
in {
  config = lib.mkIf config.common.modules.rofi.enable {
    home-manager.users."${userCfg.name}" = { config, ... }: {
      # https://mynixos.com/options/programs.rofi
      programs.rofi = {
        theme = let inherit (config.lib.formats.rasi) mkLiteral;
        in {
          "*" = { };
          "element-text, element-icon , mode-switcher" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          "window" = {
            height = 600;
            width = 800;
            border = 2;
            border-radius = 8;
            border-color = mkLiteral "@mauve";
            background-color = mkLiteral "@base";
            padding = mkLiteral "10px 0px 10px 0px";
          };
          "mainbox" = {
            background-color = mkLiteral "@base";
            text-color = mkLiteral "@surface1";
          };
          "#inputbar" = {
            children = map mkLiteral [ "prompt" "entry" ];
            border-radius = 0;
            padding = 0;
          };
          "prompt" = {
            #background-color = mkLiteral "@green";
            padding = 4;
            text-color = mkLiteral "@mauve";
            border-radius = 0;
            margin = mkLiteral "10px 10px 10px 10px";
          };
          "#textbox-prompt-colon" = {
            expand = false;
            str = ":";
            margin = mkLiteral "0px 0.3em 0em 0em";
            #text-color = mkLiteral "@foreground-color";
          };
          "entry" = {
            padding = 4;
            margin = mkLiteral "10px 10px 10px 10px";
            text-color = mkLiteral "@text";
            background-color = mkLiteral "@base";
            border-radius = 0;
          };
          "listview" = {
            border = 0;
            padding = mkLiteral "0px 0px 10px 0px";
            columns = 2;
            #background-color = mkLiteral "@base";
            cycle = true;
            scrollbar = false;
          };
          "element" = {
            padding = mkLiteral "8px 24px 8px 24px";
            #margin = mkLiteral "0px 10px 4px 4px";
            #background-color = mkLiteral "@base"; # tODO change
            #text-color = mkLiteral "@surface0";
          };

          "element-icon" = { size = 28; };

          "element" = { border-radius = 0; };

          "element selected.normal" = {
            background-color = mkLiteral "@mauve";
            text-color = mkLiteral "@crust";
          };

          "element selected.urgent" = {
            background-color = mkLiteral "@red";
            text-color = mkLiteral "@crust";
          };

          "element selected.active" = {
            background-color = mkLiteral "@mauve";
            text-color = mkLiteral "@crust";
          };
          "mode-switcher" = { spacing = 0; };

          "button" = {
            padding = 10;
            #background-color = mkLiteral "@crust";
            border-radius = 0;
            #text-color = mkLiteral "@mantle";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.5";
          };

          "button selected" = {
            background-color = mkLiteral "@base";
            text-color = mkLiteral "@mauve";
          };
        };
      };
    };
  };
}
