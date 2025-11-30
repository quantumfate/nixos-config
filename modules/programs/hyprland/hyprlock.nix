{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
  userHome = config.users.users."${userCfg.name}".home;
  wallpapersDir = "${userHome}/.config/hypr/wallpapers/";
  iconsDir = "${userHome}/.config/hypr/icons/";
  colors = config.colors.catppuccin.mocha;
in {
  home-manager.users."${userCfg.name}" = {
    home.file.".config/hypr/icons/" = {
      source = ../../../assets/icons;
      recursive = true;
    };
    catppuccin.hyprlock.enable = false;
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [{
          path = "${wallpapersDir}anime-girl.jpg";
          blur_passes = 3;
          blur_size = 8;
        }];

        label = [
          {
            monitor = "";
            text = "Layout: $LAYOUT";
            color = "${colors.text.rgb}";
            font_size = 25;
            font_family = "${config.common.style.fontFamily}";
            position = "30, -30";
            halign = "left";
            valign = "top";
          }
          {
            monitor = "";
            text = "$TIME";
            color = "${colors.text.rgb}";
            font_size = 90;
            font_family = "${config.common.style.fontFamily}";
            position = "-30, 0";
            halign = "right";
            valign = "top";
          }
          {
            monitor = "";
            text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
            color = "${colors.text.rgb}";
            font_size = 25;
            font_family = "${config.common.style.fontFamily}";
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
          {
            monitor = "";
            text = "$FPRINTPROMPT";
            color = "${colors.text.rgb}";
            font_size = 14;
            font_family = "${config.common.style.fontFamily}";
            position = "0, -107";
            halign = "center";
            valign = "center";
          }
        ];
        image = [{
          monitor = "";
          path = "${iconsDir}avatar.png";
          size = 100;
          border_color = "${colors.teal.rgb}";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }];
        input-field = [{
          monitor = "";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "${colors.teal.rgb}";
          inner_color = "${colors.surface0.rgb}";
          font_color = "${colors.text.rgb}";
          fade_on_empty = false;
          placeholder_text = ''
            <span foreground="#${colors.text.hex}"><i>󰌾 Logged in as </i><span foreground="#${colors.teal.hex}">$USER</span></span>'';
          hide_input = false;
          check_color = "${colors.teal.rgb}";
          fail_color = "${colors.red.rgb}";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "${colors.yellow.rgb}";
          position = "0, -47";
          halign = "center";
          valign = "center";
        }];
      };
    };
  };
}
