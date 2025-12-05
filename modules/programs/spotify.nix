{ config, pkgs, inputs, ... }:

let
  userCfg = config.common.user;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
      goToSong
      history
      betterGenres
      playNext
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "${config.common.style.catppuccin.flavor}";
  };
  home-manager.users."${userCfg.name}" = { services.spotifyd.enable = true; };
}
