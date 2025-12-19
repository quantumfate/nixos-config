{ config, lib, ... }:

let userCfg = config.common.user;
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
            width = 500;
            border = 2;
            border-radius = 8;
            border-color = mkLiteral "@mauve";
            background-color = mkLiteral "@base";
            padding = 10;
          };
          #"mainbox" = { background-color = mkLiteral "@base"; };
          "#inputbar" = {
            children = map mkLiteral [ "prompt" "entry" ];
            #background-color = mkLiteral "@base";
            border-radius = 8;
            padding = 0;
          };
          "prompt" = {
            #background-color = mkLiteral "@green";
            padding = 4;
            #text-color = mkLiteral "@text";
            border-radius = 8;
            margin = mkLiteral "10px 0px 10px 10px";
          };
          "#textbox-prompt-colon" = {
            expand = false;
            str = ":";
            margin = mkLiteral "0px 0.3em 0em 0em";
            #text-color = mkLiteral "@foreground-color";
          };
          "entry" = {
            padding = 6;
            margin = mkLiteral "10px 10px 10px 10px";
            #text-color = mkLiteral "@text";
            #background-color = mkLiteral "@base";
            border-radius = 8;
          };
          "listview" = {
            border = 0;
            padding = mkLiteral "6px 0 px 0px";
            margin = mkLiteral "10px 0px 0px 6px";
            columns = 1;
            #background-color = mkLiteral "@base";
            cycle = true;
            scrollbar = false;
          };
          "element" = {
            padding = mkLiteral "8px";
            margin = mkLiteral "0px 10px 4px 4px";
            #background-color = mkLiteral "@base"; # tODO change
            #text-color = mkLiteral "@surface0";
          };

          "element-icon" = { size = 28; };

          "element" = { border-radius = 8; };

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
            border-radius = 8;
            #text-color = mkLiteral "@mantle";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.5";
          };

          "button selected" = {
            background-color = mkLiteral "@mauve";
            text-color = mkLiteral "@crust";
          };
        };
      };
    };
  };
}
