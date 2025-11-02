{
  home.packages = with pkgs; [
    libnotify
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        browser = "brave -new-tab";
        dmenu = "rofi -dmenu";
        follow = "mouse";
        font = "Inconsolata Nerd Font 10";
        format = "<b>%s</b>\\n%b";
        frame_width = 2;
        geometry = "500x5-5+30";
        horizontal_padding = 8;
        icon_position = "off";
        line_height = 0;
        markup = "full";
        padding = 8;
        separator_color = "frame";
        separator_height = 2;
        transparency = 10;
        word_wrap = true;
      };
    };
  };
}
