{ config, pkgs, ... }:

let
  userCfg = config.common.user;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts";
  userHome = config.users.users."${userCfg.name}".home;
  catppuccinCfg = config.common.style.catppuccin;
  flavorHashMap = {
    frappe = "sha256-6ZkChSs77uorkGAgW8dWqBxxCyboGksE1V0ZqFd/BYY=";
    latte = "sha256-ueCdt6x3M0EKypQLaJakQwg0tzpgZdf2s1W6kREMT3k=";
    macchiato = "sha256-rNtwt4pFhArqPGPrwtuF6n+muT5B8VgG//iX/Srlo9s=";
    mocha = "sha256-4TdSa3awGONTWjn+uA5VymsUijR0jLvGQ8kWljovwGs=";
  };
  catppuccinForRanger = pkgs.fetchurl {
    url =
      "https://github.com/dfrico/catppuccin-ranger/releases/download/1.0.0/catppuccin_${catppuccinCfg.flavor}.py";
    sha256 = flavorHashMap."${catppuccinCfg.flavor}";
  };

in {
  services.locate = {
    enable = true;
    package = pkgs.mlocate;
  };
  home-manager.users."${userCfg.name}" = {
    home.packages = with pkgs; [
      fzf
      mlocate
      libsixel
      # specific for scope.sh
      bat
      imagemagick
      librsvg
      ffmpegthumbnailer
      highlight
      atool
      unrar
      _7zz
      libarchive 
      unrar
      unzip
      w3m
      poppler-utils
      djvulibre
      calibre
      transmission_4-qt
      mediainfo
      odt2txt
      sqlite
      fontforge
      openscad
      drawio
    ];
    home.file.".config/ranger/" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
    home.file.".config/ranger/rifle.conf" = { source = ./rifle.conf; };
    home.file.".config/ranger/colorschemes/catppuccin_${catppuccinCfg.flavor}.py" =
      {
        source = catppuccinForRanger;
      };
    xdg.desktopEntries."ranger" = {
      type = "Application";
      name = "ranger";
      genericName = "File Manager";
      exec = "${scriptDir}/open-tui.sh ranger %F";
      comment = "Launches the ranger file manager.";
      icon = "utilities-terminal";
      terminal = false;
      mimeType = [ "inode/directory" ];
      startupNotify = true;
      categories = [ "System" "FileTools" "FileManager" ];
      settings = {
        "X-MultipleArgs" = "false";
        #version = "1.0";
      };
    };
    programs.ranger = {
      enable = true;
      settings = {
        column_ratios = "1,3,3";
        confirm_on_delete = "never";
        scroll_offset = 8;
        unicode_ellipsis = true;
        preview_images = true;
        preview_files = true;
        preview_script = "${userHome}/.config/ranger/scope.sh";
        use_preview_script = true;
        preview_images_method = "sixel";
        colorscheme = "catppuccin_${catppuccinCfg.flavor}";
      };
      mappings = {
        "<A-f>" = "fzf_select";
        "<C-g>" = "fzf_locate";
        "<C-n>" = "fzf_content_open";
        "<C-y>" = "YankContentWl";
      };
    };
  };
}

