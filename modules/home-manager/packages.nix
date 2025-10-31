{ pkgs, ... }: {

  home.packages = with pkgs; [
    anki
    mpv
    obs-studio
    obsidian
    pavucontrol
    ranger
    nixfmt-classic
    discord
    keepassxc
    spotify
    udiskie
    udisks2
    hyprpaper
    waybar
    foot
    kitty
    rofi
    neovim
    brave
    vscode
  ];
}
