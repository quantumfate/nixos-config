{ config, lib, pkgs, ... }:

let
  catppuccinCfg = config.common.style.catppuccin;

  toRgba = color: alpha:
    "rgba(${toString color.r},${toString color.g},${toString color.b},${
      toString alpha
    })";
  toRgb = color:
    "rgb(${toString color.r},${toString color.g},${toString color.b})";

  toHex = color: "#${color}";

  rgbaify = colors:
    lib.mapAttrs (_name: color: alpha: toRgba color alpha) colors;
  rgbify = colors: lib.mapAttrs (_name: color: toRgb color) colors;
  hexify = colors: lib.mapAttrs (_name: color: toHex color) colors;

  catppuccin_palette = {
    rgb = rgbify (import ./rgb_attr.nix).${catppuccinCfg.flavor};
    rgba = rgbaify (import ./rgb_attr.nix).${catppuccinCfg.flavor};
    hsl = (import ./hsl.nix).${catppuccinCfg.flavor};
    bare_hex = (import ./bare_hex.nix).${catppuccinCfg.flavor};
    hex = hexify (import ./bare_hex.nix).${catppuccinCfg.flavor};
  };

  userCfg = config.common.user;

  catppuccinParams = {
    enable = true;
    flavor = "${catppuccinCfg.flavor}";
    accent = "${catppuccinCfg.accent}";
  };

in {
  options.theme.catppuccin = lib.mkOption {
    type = lib.types.attrs;
    readOnly = true;
    default = catppuccin_palette;
    description = "Catppuccin color palette.";
  };
  config = {
    catppuccin = catppuccinParams;
    home-manager.users."${userCfg.name}" = {
      home.packages = with pkgs; [
        catppuccin-qt5ct
        pkgs.catppuccin-cursors.mochaMauve
        (catppuccin-kvantum.override {
          accent = config.common.style.catppuccin.accent;
          variant = config.common.style.catppuccin.flavor;
        })
        (catppuccin-papirus-folders.override {
          accent = config.common.style.catppuccin.accent;
          flavor = config.common.style.catppuccin.flavor;
        })
        (catppuccin-sddm.override {
          flavor = config.common.style.catppuccin.flavor;
          font = config.common.style.fontFamily;
          fontSize = "12";
        })
      ];
      catppuccin = catppuccinParams;
    };
  };
}
