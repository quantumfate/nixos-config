{ lib, config, ... }:

let
  cfg = config.common;

  # https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h
  # https://wiki.hypr.land/Configuring/Binds/#uncommon-syms--binding-with-a-keycode
  programmerDvorakMap = {
    "1" = "ampersand"; # &
    "2" = "bracketleft"; # [
    "3" = "braceleft"; # {
    "4" = "braceright"; # }
    "5" = "parenleft"; # (
    "6" = "equal"; # =
    "7" = "asterisk"; # *
    "8" = "parenright"; # )
    "9" = "plus"; # +
    "10" = "bracketright"; # ]
  };

  defaultMap = {
    "1" = "1";
    "2" = "2";
    "3" = "3";
    "4" = "4";
    "5" = "5";
    "6" = "6";
    "7" = "7";
    "8" = "8";
    "9" = "9";
    "10" = "0";
  };

  generateBindingsList = { keyset, mainMod }:
    lib.flatten (lib.mapAttrsToList (workspaceNum: key: [
      "${mainMod}, ${key}, workspace, ${workspaceNum}"
      "${mainMod} SHIFT, ${key}, movetoworkspace, ${workspaceNum}"
    ]) keyset);

in {
  config.lib = {
    hyprland = {

      # Generates a list of Hyprland keybinding strings for switching and moving
      # windows to workspaces (1-10), adapting the keys based on the
      # common.peripherals.keyboard setting.
      # @param mainMod The Hyprland main modifier string (e.g., "$mainMod" or "SUPER").
      # @returns A list of Hyprland bind strings.
      generateKeybindings = { mainMod ? "$mainMod" }:
        let
          # Select the appropriate key map based on the configured keyboard
          keyset = if cfg.peripherals.keyboard == "programmer-dvorak" then
            programmerDvorakMap
          else
            defaultMap;
        in generateBindingsList { inherit keyset mainMod; };
    };
  };
}
