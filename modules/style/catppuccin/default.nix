{ config, lib, pkgs, ... }:

let
  catppuccinCfg = config.common.style.catppuccin;

  toRgba = color: alpha:
    "rgba(${toString color.r},${toString color.g},${toString color.b},${
      toString alpha
    })";
  toRgb = color:
    "rgb(${toString color.r},${toString color.g},${toString color.b})";

  toHex = color: "#${lib.strings.toUpper color}";

  rgbaify = colors:
    lib.mapAttrs (_name: color: alpha: toRgba color alpha) colors;
  rgbify = colors: lib.mapAttrs (_name: color: toRgb color) colors;
  hexify = colors: lib.mapAttrs (_name: color: toHex color) colors;
  capitalize_hex = colors: lib.mapAttrs (_name: color: lib.strings.toUpper color) colors;

  calc_rgba_hex = color: alpha:
    "${color}" + lib.toHexString (builtins.floor (alpha * 255));

  rgba_bare_hexify = colors:
    lib.mapAttrs (_name: color: alpha: lib.strings.toUpper (calc_rgba_hex color alpha)) colors;

  rgba_hexify = colors:
    lib.mapAttrs (_name: color: alpha: toHex (calc_rgba_hex color alpha))
    colors;

  catppuccin_palette = {
    rgb = rgbify (import ./rgb_attr.nix).${catppuccinCfg.flavor};
    rgba = rgbaify (import ./rgb_attr.nix).${catppuccinCfg.flavor};
    hsl = (import ./hsl.nix).${catppuccinCfg.flavor};
    bare_hex = capitalize_hex (import ./bare_hex.nix).${catppuccinCfg.flavor};
    hex = hexify (import ./bare_hex.nix).${catppuccinCfg.flavor};
    rgba_hex = rgba_hexify (import ./bare_hex.nix).${catppuccinCfg.flavor};
    rgba_bare_hex =
      rgba_bare_hexify (import ./bare_hex.nix).${catppuccinCfg.flavor};
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
          accent = catppuccinCfg.accent;
          variant = catppuccinCfg.flavor;
        })
        (catppuccin-papirus-folders.override {
          accent = catppuccinCfg.accent;
          flavor = catppuccinCfg.flavor;
        })
      ];
      catppuccin = catppuccinParams;
    };
  };
}
