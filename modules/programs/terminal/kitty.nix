{ config, ... }:

let userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "${config.common.style.terminalFont}";
        size = 14;
      };
      settings = {

        scrollback_lines = 2000;
        scrollbar = "never";
        enable_audio_bell = "no";
        window_padding_width = "20 15";
        confirm_os_window_close = 0;
      };
    };
  };
}
