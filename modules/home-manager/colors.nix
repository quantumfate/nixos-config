let
  flavor = "mocha";
  accent = "rosewater";
in {
  catppuccin = {
    enable = true; # enables everything
    flavor = flavor;
    accent = accent;

    # obsolete because of catppuccin.enable = true
    alacritty.enable = true;
    chromium.enable = true;
    brave.enable = true;
    hyprland.enable = true;
    kitty.enable = true;
    rofi.enable = true;
    vscode.profiles.default.enable = true;
    waybar.enable = true;
    obs.enable = true;
  };
}
