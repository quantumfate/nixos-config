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
          
        }

        #waybar {
          background-color: @base;
        }

        #workspaces button {
          box-shadow: none;
          text-shadow: none;
          padding: 0px;
          border-radius: 2px;
          margin: 5px 0px 5px 3px;
          padding: 0 2px 0 2px;
          background-color: @maroon;
          color: @crust;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        #workspaces button.active {
          background: @teal;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        #workspaces button:hover {
          background: @teal;
          border-color: @teal;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }


      '';
    };
  };
}
