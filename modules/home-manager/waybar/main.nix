{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        include = "/home/quantum/.config/waybar/modules";
        position = "top";
        height = 35;
        ipc = true;
        margin-right = 0;
        margin-left = 0;
        padding-right = 30;
        layer = "top";
        spacing = 6;
        fixed-center = true;
        modules-left =
          [ "hyprland/workspaces" "cpu" "memory" "disk" "network" ];
        modules-center =
          [ "hyprland/window" "custom/spotify" "custom/weather" ];
        modules-right =
          [ "hyprland/language" "pulseaudio" "clock" "tray" "custom/dunst" ];
      };
    };
  };
  home.file.".config/waybar/scripts/" = {
    source = ./scripts;
    recursive = true;
  };
}
