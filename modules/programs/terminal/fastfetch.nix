{ config, ... }:

let
  userCfg = config.common.user;
in
{

  home-manager.users."${userCfg.name}" = {

    programs.fastfetch = {
      enable = true;
      settings = {
        # https://github.com/fastfetch-cli/fastfetch/issues/656#issuecomment-1849448969
        logo = {
          source = "${../../../assets/fastfetch/yukino.png}";
          type = "kitty";
          padding = {
            top = 1;
          };
          height = 12;
        };
        display = {
          separator = " ";
        };
        modules = [
          {
            key = "╭────────────╮";
            type = "custom";
          }
          {
            key = "│ {#31}  user    {#keys}│";
            type = "title";
            format = "{user-name}";
          }
          {
            key = "│ {#32}󰇅  hname   {#keys}│";
            type = "title";
            format = "{host-name}";
          }
          {
            key = "│ {#33}󰅐  uptime  {#keys}│";
            type = "uptime";
          }

          {
            key = "│ {#35}  kernel  {#keys}│";
            type = "kernel";
          }
          {
            key = "│ {#36}󰇄  desktop {#keys}│";
            type = "de";
          }
          {
            key = "│ {#31}  term    {#keys}│";
            type = "terminal";
          }
          {
            key = "│ {#32}  shell   {#keys}│";
            type = "shell";
          }
          {
            key = "│ {#33}󰍛  cpu     {#keys}│";
            type = "cpu";
            showPeCoreCount = true;
          }
          {
            key = "│ {#34}󰉉  disk    {#keys}│";
            type = "disk";
            folders = "/";
          }
          {
            key = "│ {#35}  memory  {#keys}│";
            type = "memory";
          }
          {
            key = "│ {#36}󰩟  network {#keys}│";
            type = "localip";
            format = "{ipv4} ({ifname})";
          }
          {
            key = "├────────────┤";
            type = "custom";
          }
          {
            key = "│ {#39}  colors  {#keys}│";
            type = "colors";
            symbol = "circle";
          }
          {
            key = "╰────────────╯";
            type = "custom";
          }
        ];
      };
    };
  };
}
