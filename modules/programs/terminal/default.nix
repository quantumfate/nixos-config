{ config, ... }:

let
  userCfg = config.common.user;
in
{
  imports = [ ./foot.nix ./kitty.nix ./ranger ./shell ./btop.nix ];

  home-manager.users."${userCfg.name}" = {
    home.packages = with pkgs; [
      neofetch
    ];
  };
}
