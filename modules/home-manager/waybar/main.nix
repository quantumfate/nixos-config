{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        color: @text;
        background-color: @base;
        border: none;
        border-radius: 0;
        font-family: Fira Code Nerd Font Mono;
        font-size: 15px;
        min-height: 0;
      }

      window#waybar {
      }

      #workspaces {
        margin: 5px;
        margin-left: 10px;
        border-radius: 5px;
      }
      #workspaces button {
        background-color: @base;
        color: @text;
      }

      #workspaces button.focused {
        border-radius: 5px;
      }

      #workspaces button:hover {
        background-color: @mauve;
        border-radius: 5px;
      }


      #wlr-workspaces,
      #custom-menu, 
      #cpu, 
      #memory, 
      #disk, 
      #network, 
      #custom-spotify,
      #custom-weather, 
      #custom-keybindings, 
      #backlight, 
      #custom-updater, 
      #pulseaudio, 
      #battery, 
      #custom-date, 
      #clock, 
      #tray,
      #custom-power {
        background-color: @base;
        padding: 0px 7px 0px 7px;
      }

      .custom-spotify {
        border-radius: 5px 5px 5px 5px;
        color: @green;
      }
      #custom-updater {
        color: @green;
      }
      #custom-keybindings {
        color: @blue;
        border-radius: 5px 0px 0px 5px;
      }
      #memory {
        color: @rosewater;
      }

      #disk {
        color: @lavender;
      }

      #custom-date {
      color: @mauve;
      }
      #cpu {
        color: @teal;
      }
      #custom-power {
        color: @red;
        background-color: @surface0;
        border-radius: 5px;
        margin-right: 10px;
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 0px;
        padding: 0px 14px 0px 12px;
      }

      #clock {
        color: @mauve;
        border-radius: 0px 5px 5px 0px;
      }

      #battery {
        color: @green;
      }

      @keyframes blink {
        to {
            background-color: @red;
            color: black;
        }
      }

      #battery.charging {
        color: @peach;
      }

      #backlight {
        color: #BF616A;
      }

      #custom-weather {
        color: @pink;
      }


      #battery.critical:not(.charging) {
        background-color: @rosewater;
        color: @red;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #network {
        color: @yellow;
      }

      #pulseaudio {
        color: @teal;
        border-radius: 0px 0px 0px 0px;
      }

      #tray {
        border-radius: 5px 5px 5px 5px;
      }
    '';
    #style = ./style.css;
    settings = {
      mainBar = {
        include = "/home/quantum/.config/waybar/modules";
        position = "top";
        height = 35;
        ipc = true;
        margin-left = 0;
        layer = "top";
        margin-right = 0;
        spacing = 6;
        fixed-center = true;
        modules-left =
          [ "hyprland/workspaces" "cpu" "memory" "disk" "network" ];
        modules-center =
          [ "hyprland/window" "custom/spotify" "custom/weather" ];
        modules-right = [ "hyprland/language" "pulseaudio" "clock" "tray" "custom/dunst"];
      };
    };
  };
}
