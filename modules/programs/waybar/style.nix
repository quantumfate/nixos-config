{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
  scriptLocation = "/home/${userCfg.userName}/.config/waybar/scripts";
in {
  home-manager.users."${userCfg.userName}" = {
    programs.waybar = {
      style = ''
* {
  font-family: Fira Code Nerd Font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
  font-size: 13px;
}

#waybar {
  background-color: transparent;
  color: @crust;
}

.modules-left {
  margin: 0 0 0 8px;
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
#custom-dunst {
  background-color: @surface0;
  color: @mauve;
  border: 2px solid @mauve;
  border-radius: 10px;
  padding: 0 15px;
  margin-right: 10px;
}

#workspaces {
  background-color: @surface0;
  border: 2px solid @teal;
  border-radius: 10px;
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
  border: 2px solid @mauve;
  background-color: @surface0;
  border-radius: 10px;
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
  border-bottom: 2px solid @maroon;
  border-top: 2px solid @maroon;
}

#custom-lock {
  border-left: 2px solid @maroon;
  border-radius: 10px 0 0 10px;
  padding-left: 14px;
  padding-right: 10px;
}

#custom-reboot {
  padding: 0 10px;
}

#custom-power {
  border-right: 2px solid @maroon;
  border-radius: 0 10px 10px 0;
  padding-right: 14px;
  padding-left: 10px;
} 
      '';
    };
  };
}
