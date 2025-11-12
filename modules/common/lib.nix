{ lib, config, ... }:

let
  cfg = config.common;
  
  dvorakMap = {
    "1" = "&";
    "2" = "[";
    "3" = "{";
    "4" = "}";
    "5" = "(";
    "6" = "=";
    "7" = "*";
    "8" = ")";
    "9" = "+";
    "0" = "]";
  };

  defaultMap = {
    "1" = "1"; "2" = "2"; "3" = "3"; "4" = "4"; "5" = "5";
    "6" = "6"; "7" = "7"; "8" = "8"; "9" = "9"; "0" = "0";
  };
  
  generateBindingsList = { keyset, mainMod }:
    lib.flatten (lib.mapAttrsToList (workspaceNum, key) : [
      "${mainMod}, ${key}, workspace, ${workspaceNum}"
      "${mainMod} SHIFT, ${key}, movetoworkspace, ${workspaceNum}"
    ] keyset);

in {
  config.lib.common = {
    
    /**
     * Generates a list of Hyprland keybinding strings for switching and moving 
     * windows to workspaces (1-10), adapting the keys based on the 
     * common.peripherals.keyboard setting.
     * * @param mainMod The Hyprland main modifier string (e.g., "$mainMod" or "SUPER").
     * @returns A list of Hyprland bind strings.
     */
    generateKeybindings = { mainMod ? "$mainMod" }:
      let
        # Select the appropriate key map based on the configured keyboard
        keyset =
          if cfg.peripherals.keyboard == "qmk-dvorak"
          then dvorakMap
          else defaultMap;
      in
      generateBindingsList { inherit keyset mainMod; };
  };
}