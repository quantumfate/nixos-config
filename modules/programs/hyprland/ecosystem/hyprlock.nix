{ config, lib, ... }:

let
  userCfg = config.common.user;
  userHome = config.users.users."${userCfg.name}".home;
  wallpapersDir = "${userHome}/.config/hypr/wallpapers/";
  iconsDir = "${userHome}/.config/hypr/icons/";
  catppuccin = config.theme.catppuccin;
in {
  home-manager.users."${userCfg.name}" = {
    home.file.".config/hypr/icons/" = {
      source = ../../../../assets/icons;
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
            color = "${catppuccin.rgb.text}";
            font_size = 25;
            font_family = "${config.common.style.guiFont}";
            position = "30, -30";
            halign = "left";
            valign = "top";
          }
          {
            monitor = "";
            text = "$TIME";
            color = "${catppuccin.rgb.text}";
            font_size = 90;
            font_family = "${config.common.style.guiFont}";
            position = "-30, 0";
            halign = "right";
            valign = "top";
          }
          {
            monitor = "";
            text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
            color = "${catppuccin.rgb.text}";
            font_size = 25;
            font_family = "${config.common.style.guiFont}";
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
          {
            monitor = "";
            text = "$FPRINTPROMPT";
            color = "${catppuccin.rgb.text}";
            font_size = 14;
            font_family = "${config.common.style.guiFont}";
            position = "0, -107";
            halign = "center";
            valign = "center";
          }
        ] ++ lib.optionals (config.networking.hostName == "quantum-laptop") [{
          monitor = "";
          text = "cmd[update:1000] ${userHome}/.config/hypr/scripts/interface/battery.sh";
          color = "${catppuccin.rgb.text}";
          font_size = 14;
          font_family = "${config.common.style.guiFont}";
          position = "30, -110";
          halign = "left";
          valign = "top";
        }];

        image = [{
          monitor = "";
          path = "${iconsDir}avatar-small.png";
          size = 100;
          border_color = "${catppuccin.rgb.mauve}";
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
          outer_color = "${catppuccin.rgb.mauve}";
          inner_color = "${catppuccin.rgb.surface0}";
          font_color = "${catppuccin.rgb.text}";
          fade_on_empty = false;
          placeholder_text = ''
            <span foreground="#${catppuccin.hex.text}"><i>󰌾 Logged in as </i><span foreground="#${catppuccin.hex.mauve}">$USER</span></span>'';
          hide_input = false;
          check_color = "${catppuccin.hex.teal}";
          fail_color = "${catppuccin.hex.red}";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "${catppuccin.hex.yellow}";
          position = "0, -47";
          halign = "center";
          valign = "center";
        }];
      };
    };
  };
}
