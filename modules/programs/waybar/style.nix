{ config, lib, ... }:

let
  userCfg = config.common.user;
  colors = config.colors.catppuccin.mocha;
  rgbToRgba = rgbString: alpha:
    let
      content = lib.strings.substring 4 (lib.strings.stringLength rgbString - 5)
        rgbString;
    in "rgba(${content}, ${toString alpha})";
    
  borderColor = rgbToRgba colors.crust.rgb 0.6;
in {
  home-manager.users."${userCfg.name}" = {
    programs.waybar = {
      style = ''
        * {
          font-family: ${config.common.style.fontFamily}, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
        }

        #waybar {
          background-color: transparent;
          color: @crust;
        }

        .modules-left {
          margin: 0 0 0 11px;
        }

        .modules-right {
          margin: 0 11px 0 0;
        }

        #cpu,
        #disk,
        #memory,
        #network,
        #language,
        #pulseaudio,
        #clock,
        #tray,
        #custom-mako,
        #battery {
          background-color: @surface0;
          color: @teal;
          border: 2px solid ${borderColor};
          border-radius: 8px;
          padding: 0 15px;
          margin-right: 10px;
        }

        #workspaces {
          background-color: @surface0;
          border: 2px solid ${borderColor};
          border-radius: 8px;
          padding: 0 5px;
          margin-right: 10px;
        }

        #workspaces button {
          box-shadow: none;
          text-shadow: none;
          padding: 0 4px;
          color: @maroon;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        #workspaces button.active,
        #workspaces button:hover {
          color: @teal;
        }

        #workspaces button:hover {
          background: @surface0;
          border-color: @surface0;
        }

        #window {
          border: 2px solid ${borderColor};
          background-color: @surface0;
          border-radius: 8px;
          padding: 0 10px;
          color: @mauve;
        }

        window#waybar.empty #window {
          border: none;
          background-color: transparent;
        }

        #custom-lock,
        #custom-reboot,
        #custom-power {
          background-color: @surface0;
          border-bottom: 2px solid ${borderColor};
          border-top: 2px solid ${borderColor};
        }

        #custom-lock {
          border-left: 2px solid ${borderColor};
          border-radius: 8px 0 0 8px;
          padding-left: 14px;
          padding-right: 10px;
        }

        #custom-reboot {
          padding: 0 10px;
        }

        #custom-power {
          border-right: 2px solid ${borderColor};
          border-radius: 0 8px 8px 0;
          padding-right: 14px;
          padding-left: 10px;
        } 

        tooltip {
          margin-top: 2px;
          background: ${rgbToRgba colors.base.rgb 0.8};
          border: 2px solid ${borderColor};
          border-radius: 8px;
        }
        tooltip label {
          color: @text;
        }

      '';
    };
  };
}
