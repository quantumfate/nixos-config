let
  flavor = "mocha";
  accent = "lavender";
in {
  catppuccin = {
    enable = true; # enables everything
    flavor = flavor;
    accent = accent;

    # obsolete because of catppuccin.enable = true
    tty.enable = true;
    alacritty.enable = true;
    grub.enable = true;
    chromium.enable = true;
    brave.enable = true;
    dunst.enable = true;
    gtk.enable = true;
    hyprland.enable = true;
    kitty.enable = true;
    rofi.enable = true;
    vscode.enable = true;
    waybar.enable = true;
    obs.enable = true;
  };
}
