{ config, lib, ... }:

let
  cfg = config.colorscheme.catppuccin;
  hostName = config.networking.hostName;
  userCfg = config.mainUser;

  flavor = "mocha";
  accent = "rosewater";

  catppuccinCfg = {
    enable = true;
    flavor = "mocha";
    accent = "rosewater";
  };

  # Helper function to convert the combined color string (e.g., "rgb(x, y, z) hsl(h, s%, l%)")
  # into a structured attribute set.
  parseColorString = colorString:
    let
      # rgb(220, 138, 120) -> ["220, 138, 120"]
      rgbMatch = builtins.match "rgb\\(([^)]+)\\)" colorString;
      # hsl(11, 59%, 67%) -> ["11, 59%, 67%"]
      hslMatch = builtins.match "hsl\\(([^)]+)\\)" colorString;

      # Format: "rgb(r, g, b)"
      rgb = builtins.elemAt rgbMatch 0;
      # Format: "hsl(h, s%, l%)"
      hsl = builtins.elemAt hslMatch 0;
    in { inherit rgb hsl; };

  palette = {
    # 🌻 Latte
    latte = {
      rosewater = {
        hex = "#dc8a78";
        inherit (parseColorString "rgb(220, 138, 120) hsl(11, 59%, 67%)")
          rgb hsl;
      };
      flamingo = {
        hex = "#dd7878";
        inherit (parseColorString "rgb(221, 120, 120) hsl(0, 60%, 67%)")
          rgb hsl;
      };
      pink = {
        hex = "#ea76cb";
        inherit (parseColorString "rgb(234, 118, 203) hsl(316, 73%, 69%)")
          rgb hsl;
      };
      mauve = {
        hex = "#8839ef";
        inherit (parseColorString "rgb(136, 57, 239) hsl(266, 85%, 58%)")
          rgb hsl;
      };
      red = {
        hex = "#d20f39";
        inherit (parseColorString "rgb(210, 15, 57) hsl(347, 87%, 44%)")
          rgb hsl;
      };
      maroon = {
        hex = "#e64553";
        inherit (parseColorString "rgb(230, 69, 83) hsl(355, 76%, 59%)")
          rgb hsl;
      };
      peach = {
        hex = "#fe640b";
        inherit (parseColorString "rgb(254, 100, 11) hsl(22, 99%, 52%)")
          rgb hsl;
      };
      yellow = {
        hex = "#df8e1d";
        inherit (parseColorString "rgb(223, 142, 29) hsl(35, 77%, 49%)")
          rgb hsl;
      };
      green = {
        hex = "#40a02b";
        inherit (parseColorString "rgb(64, 160, 43) hsl(109, 58%, 40%)")
          rgb hsl;
      };
      teal = {
        hex = "#179299";
        inherit (parseColorString "rgb(23, 146, 153) hsl(183, 74%, 35%)")
          rgb hsl;
      };
      sky = {
        hex = "#04a5e5";
        inherit (parseColorString "rgb(4, 165, 229) hsl(197, 97%, 46%)")
          rgb hsl;
      };
      sapphire = {
        hex = "#209fb5";
        inherit (parseColorString "rgb(32, 159, 181) hsl(189, 70%, 42%)")
          rgb hsl;
      };
      blue = {
        hex = "#1e66f5";
        inherit (parseColorString "rgb(30, 102, 245) hsl(220, 91%, 54%)")
          rgb hsl;
      };
      lavender = {
        hex = "#7287fd";
        inherit (parseColorString "rgb(114, 135, 253) hsl(231, 97%, 72%)")
          rgb hsl;
      };
      text = {
        hex = "#4c4f69";
        inherit (parseColorString "rgb(76, 79, 105) hsl(234, 16%, 35%)")
          rgb hsl;
      };
      subtext1 = {
        hex = "#5c5f77";
        inherit (parseColorString "rgb(92, 95, 119) hsl(233, 13%, 41%)")
          rgb hsl;
      };
      subtext0 = {
        hex = "#6c6f85";
        inherit (parseColorString "rgb(108, 111, 133) hsl(233, 10%, 47%)")
          rgb hsl;
      };
      overlay2 = {
        hex = "#7c7f93";
        inherit (parseColorString "rgb(124, 127, 147) hsl(232, 10%, 53%)")
          rgb hsl;
      };
      overlay1 = {
        hex = "#8c8fa1";
        inherit (parseColorString "rgb(140, 143, 161) hsl(231, 10%, 59%)")
          rgb hsl;
      };
      overlay0 = {
        hex = "#9ca0b0";
        inherit (parseColorString "rgb(156, 160, 176) hsl(228, 11%, 65%)")
          rgb hsl;
      };
      surface2 = {
        hex = "#acb0be";
        inherit (parseColorString "rgb(172, 176, 190) hsl(227, 12%, 71%)")
          rgb hsl;
      };
      surface1 = {
        hex = "#bcc0cc";
        inherit (parseColorString "rgb(188, 192, 204) hsl(225, 14%, 77%)")
          rgb hsl;
      };
      surface0 = {
        hex = "#ccd0da";
        inherit (parseColorString "rgb(204, 208, 218) hsl(223, 16%, 83%)")
          rgb hsl;
      };
      base = {
        hex = "#eff1f5";
        inherit (parseColorString "rgb(239, 241, 245) hsl(220, 23%, 95%)")
          rgb hsl;
      };
      mantle = {
        hex = "#e6e9ef";
        inherit (parseColorString "rgb(230, 233, 239) hsl(220, 22%, 92%)")
          rgb hsl;
      };
      crust = {
        hex = "#dce0e8";
        inherit (parseColorString "rgb(220, 224, 232) hsl(220, 21%, 89%)")
          rgb hsl;
      };
    };

    # 🪴 Frappé
    frappe = {
      rosewater = {
        hex = "#f2d5cf";
        inherit (parseColorString "rgb(242, 213, 207) hsl(10, 57%, 88%)")
          rgb hsl;
      };
      flamingo = {
        hex = "#eebebe";
        inherit (parseColorString "rgb(238, 190, 190) hsl(0, 59%, 84%)")
          rgb hsl;
      };
      pink = {
        hex = "#f4b8e4";
        inherit (parseColorString "rgb(244, 184, 228) hsl(316, 73%, 84%)")
          rgb hsl;
      };
      mauve = {
        hex = "#ca9ee6";
        inherit (parseColorString "rgb(202, 158, 230) hsl(277, 59%, 76%)")
          rgb hsl;
      };
      red = {
        hex = "#e78284";
        inherit (parseColorString "rgb(231, 130, 132) hsl(359, 68%, 71%)")
          rgb hsl;
      };
      maroon = {
        hex = "#ea999c";
        inherit (parseColorString "rgb(234, 153, 156) hsl(358, 66%, 76%)")
          rgb hsl;
      };
      peach = {
        hex = "#ef9f76";
        inherit (parseColorString "rgb(239, 159, 118) hsl(20, 79%, 70%)")
          rgb hsl;
      };
      yellow = {
        hex = "#e5c890";
        inherit (parseColorString "rgb(229, 200, 144) hsl(40, 62%, 73%)")
          rgb hsl;
      };
      green = {
        hex = "#a6d189";
        inherit (parseColorString "rgb(166, 209, 137) hsl(96, 44%, 68%)")
          rgb hsl;
      };
      teal = {
        hex = "#81c8be";
        inherit (parseColorString "rgb(129, 200, 190) hsl(172, 39%, 65%)")
          rgb hsl;
      };
      sky = {
        hex = "#99d1db";
        inherit (parseColorString "rgb(153, 209, 219) hsl(189, 48%, 73%)")
          rgb hsl;
      };
      sapphire = {
        hex = "#85c1dc";
        inherit (parseColorString "rgb(133, 193, 220) hsl(199, 55%, 69%)")
          rgb hsl;
      };
      blue = {
        hex = "#8caaee";
        inherit (parseColorString "rgb(140, 170, 238) hsl(222, 74%, 74%)")
          rgb hsl;
      };
      lavender = {
        hex = "#babbf1";
        inherit (parseColorString "rgb(186, 187, 241) hsl(239, 66%, 84%)")
          rgb hsl;
      };
      text = {
        hex = "#c6d0f5";
        inherit (parseColorString "rgb(198, 208, 245) hsl(227, 70%, 87%)")
          rgb hsl;
      };
      subtext1 = {
        hex = "#b5bfe2";
        inherit (parseColorString "rgb(181, 191, 226) hsl(227, 44%, 80%)")
          rgb hsl;
      };
      subtext0 = {
        hex = "#a5adce";
        inherit (parseColorString "rgb(165, 173, 206) hsl(228, 29%, 73%)")
          rgb hsl;
      };
      overlay2 = {
        hex = "#949cbb";
        inherit (parseColorString "rgb(148, 156, 187) hsl(228, 22%, 66%)")
          rgb hsl;
      };
      overlay1 = {
        hex = "#838ba7";
        inherit (parseColorString "rgb(131, 139, 167) hsl(227, 17%, 58%)")
          rgb hsl;
      };
      overlay0 = {
        hex = "#737994";
        inherit (parseColorString "rgb(115, 121, 148) hsl(229, 13%, 52%)")
          rgb hsl;
      };
      surface2 = {
        hex = "#626880";
        inherit (parseColorString "rgb(98, 104, 128) hsl(228, 13%, 44%)")
          rgb hsl;
      };
      surface1 = {
        hex = "#51576d";
        inherit (parseColorString "rgb(81, 87, 109) hsl(227, 15%, 37%)")
          rgb hsl;
      };
      surface0 = {
        hex = "#414559";
        inherit (parseColorString "rgb(65, 69, 89) hsl(230, 16%, 30%)") rgb hsl;
      };
      base = {
        hex = "#303446";
        inherit (parseColorString "rgb(48, 52, 70) hsl(229, 19%, 23%)") rgb hsl;
      };
      mantle = {
        hex = "#292c3c";
        inherit (parseColorString "rgb(41, 44, 60) hsl(231, 19%, 20%)") rgb hsl;
      };
      crust = {
        hex = "#232634";
        inherit (parseColorString "rgb(35, 38, 52) hsl(229, 20%, 17%)") rgb hsl;
      };
    };

    # 🌺 Macchiato
    macchiato = {
      rosewater = {
        hex = "#f4dbd6";
        inherit (parseColorString "rgb(244, 219, 214) hsl(10, 56%, 90%)")
          rgb hsl;
      };
      flamingo = {
        hex = "#eed49f";
        inherit (parseColorString "rgb(238, 212, 159) hsl(45, 71%, 78%)")
          rgb hsl;
      };
      pink = {
        hex = "#f5bde6";
        inherit (parseColorString "rgb(245, 189, 230) hsl(316, 74%, 85%)")
          rgb hsl;
      };
      mauve = {
        hex = "#c6a0f6";
        inherit (parseColorString "rgb(198, 160, 246) hsl(270, 79%, 80%)")
          rgb hsl;
      };
      red = {
        hex = "#ed8796";
        inherit (parseColorString "rgb(237, 135, 150) hsl(351, 74%, 73%)")
          rgb hsl;
      };
      maroon = {
        hex = "#ee99a0";
        inherit (parseColorString "rgb(238, 153, 160) hsl(356, 70%, 78%)")
          rgb hsl;
      };
      peach = {
        hex = "#f5a97f";
        inherit (parseColorString "rgb(245, 169, 127) hsl(23, 89%, 73%)")
          rgb hsl;
      };
      yellow = {
        hex = "#eed49f";
        inherit (parseColorString "rgb(238, 212, 159) hsl(45, 71%, 78%)")
          rgb hsl;
      };
      green = {
        hex = "#a6da95";
        inherit (parseColorString "rgb(166, 218, 149) hsl(107, 49%, 72%)")
          rgb hsl;
      };
      teal = {
        hex = "#8bd5ca";
        inherit (parseColorString "rgb(139, 213, 202) hsl(172, 45%, 69%)")
          rgb hsl;
      };
      sky = {
        hex = "#91d7e3";
        inherit (parseColorString "rgb(145, 215, 227) hsl(188, 55%, 73%)")
          rgb hsl;
      };
      sapphire = {
        hex = "#7dc4e4";
        inherit (parseColorString "rgb(125, 196, 228) hsl(200, 62%, 69%)")
          rgb hsl;
      };
      blue = {
        hex = "#8aadf4";
        inherit (parseColorString "rgb(138, 173, 244) hsl(222, 85%, 75%)")
          rgb hsl;
      };
      lavender = {
        hex = "#b7bdf8";
        inherit (parseColorString "rgb(183, 189, 248) hsl(235, 87%, 85%)")
          rgb hsl;
      };
      text = {
        hex = "#cad3f5";
        inherit (parseColorString "rgb(202, 211, 245) hsl(228, 70%, 88%)")
          rgb hsl;
      };
      subtext1 = {
        hex = "#b8c0e0";
        inherit (parseColorString "rgb(184, 192, 224) hsl(228, 45%, 80%)")
          rgb hsl;
      };
      subtext0 = {
        hex = "#a5adcb";
        inherit (parseColorString "rgb(165, 173, 203) hsl(228, 30%, 72%)")
          rgb hsl;
      };
      overlay2 = {
        hex = "#939ab7";
        inherit (parseColorString "rgb(147, 154, 183) hsl(229, 23%, 65%)")
          rgb hsl;
      };
      overlay1 = {
        hex = "#8087a2";
        inherit (parseColorString "rgb(128, 135, 162) hsl(228, 19%, 57%)")
          rgb hsl;
      };
      overlay0 = {
        hex = "#6e738d";
        inherit (parseColorString "rgb(110, 115, 141) hsl(231, 17%, 49%)")
          rgb hsl;
      };
      surface2 = {
        hex = "#5b6078";
        inherit (parseColorString "rgb(91, 96, 120) hsl(232, 15%, 41%)")
          rgb hsl;
      };
      surface1 = {
        hex = "#494d64";
        inherit (parseColorString "rgb(73, 77, 100) hsl(233, 16%, 34%)")
          rgb hsl;
      };
      surface0 = {
        hex = "#363a4f";
        inherit (parseColorString "rgb(54, 58, 79) hsl(231, 19%, 26%)") rgb hsl;
      };
      base = {
        hex = "#24273a";
        inherit (parseColorString "rgb(36, 39, 58) hsl(233, 23%, 18%)") rgb hsl;
      };
      mantle = {
        hex = "#1e2030";
        inherit (parseColorString "rgb(30, 32, 48) hsl(235, 23%, 15%)") rgb hsl;
      };
      crust = {
        hex = "#181926";
        inherit (parseColorString "rgb(24, 25, 38) hsl(236, 23%, 12%)") rgb hsl;
      };
    };

    # 🌿 Mocha
    mocha = {
      rosewater = {
        hex = "#f5e0dc";
        inherit (parseColorString "rgb(245, 224, 220) hsl(10, 56%, 91%)")
          rgb hsl;
      };
      flamingo = {
        hex = "#f2cdcd";
        inherit (parseColorString "rgb(242, 205, 205) hsl(0, 56%, 88%)")
          rgb hsl;
      };
      pink = {
        hex = "#f5c2e7";
        inherit (parseColorString "rgb(245, 194, 231) hsl(316, 75%, 86%)")
          rgb hsl;
      };
      mauve = {
        hex = "#cba6f7";
        inherit (parseColorString "rgb(203, 166, 247) hsl(266, 85%, 81%)")
          rgb hsl;
      };
      red = {
        hex = "#f38ba8";
        inherit (parseColorString "rgb(243, 139, 168) hsl(343, 81%, 75%)")
          rgb hsl;
      };
      maroon = {
        hex = "#eba0ac";
        inherit (parseColorString "rgb(235, 160, 172) hsl(351, 65%, 77%)")
          rgb hsl;
      };
      peach = {
        hex = "#fab387";
        inherit (parseColorString "rgb(250, 179, 135) hsl(25, 92%, 75%)")
          rgb hsl;
      };
      yellow = {
        hex = "#f9e2af";
        inherit (parseColorString "rgb(249, 226, 175) hsl(42, 86%, 83%)")
          rgb hsl;
      };
      green = {
        hex = "#a6e3a1";
        inherit (parseColorString "rgb(166, 227, 161) hsl(115, 53%, 76%)")
          rgb hsl;
      };
      teal = {
        hex = "#94e2d5";
        inherit (parseColorString "rgb(148, 226, 213) hsl(172, 59%, 73%)")
          rgb hsl;
      };
      sky = {
        hex = "#89dceb";
        inherit (parseColorString "rgb(137, 220, 235) hsl(189, 72%, 73%)")
          rgb hsl;
      };
      sapphire = {
        hex = "#74c7ec";
        inherit (parseColorString "rgb(116, 199, 236) hsl(199, 76%, 69%)")
          rgb hsl;
      };
      blue = {
        hex = "#89b4fa";
        inherit (parseColorString "rgb(137, 180, 250) hsl(219, 92%, 76%)")
          rgb hsl;
      };
      lavender = {
        hex = "#b4befe";
        inherit (parseColorString "rgb(180, 190, 254) hsl(235, 96%, 85%)")
          rgb hsl;
      };
      text = {
        hex = "#cdd6f4";
        inherit (parseColorString "rgb(205, 214, 244) hsl(227, 70%, 88%)")
          rgb hsl;
      };
      subtext1 = {
        hex = "#bac2de";
        inherit (parseColorString "rgb(186, 194, 222) hsl(227, 44%, 80%)")
          rgb hsl;
      };
      subtext0 = {
        hex = "#a6adc8";
        inherit (parseColorString "rgb(166, 173, 200) hsl(229, 29%, 72%)")
          rgb hsl;
      };
      overlay2 = {
        hex = "#9399b2";
        inherit (parseColorString "rgb(147, 153, 178) hsl(229, 22%, 64%)")
          rgb hsl;
      };
      overlay1 = {
        hex = "#7f849c";
        inherit (parseColorString "rgb(127, 132, 156) hsl(230, 18%, 56%)")
          rgb hsl;
      };
      overlay0 = {
        hex = "#6c7086";
        inherit (parseColorString "rgb(108, 112, 134) hsl(233, 17%, 47%)")
          rgb hsl;
      };
      surface2 = {
        hex = "#585b70";
        inherit (parseColorString "rgb(88, 91, 112) hsl(235, 15%, 39%)")
          rgb hsl;
      };
      surface1 = {
        hex = "#45475a";
        inherit (parseColorString "rgb(69, 71, 90) hsl(235, 17%, 31%)") rgb hsl;
      };
      surface0 = {
        hex = "#313244";
        inherit (parseColorString "rgb(49, 50, 68) hsl(237, 18%, 23%)") rgb hsl;
      };
      base = {
        hex = "#1e1e2e";
        inherit (parseColorString "rgb(30, 30, 46) hsl(240, 22%, 15%)") rgb hsl;
      };
      mantle = {
        hex = "#181825";
        inherit (parseColorString "rgb(24, 24, 37) hsl(240, 22%, 12%)") rgb hsl;
      };
      crust = {
        hex = "#11111b";
        inherit (parseColorString "rgb(17, 17, 27) hsl(240, 23%, 9%)") rgb hsl;
      };
    };
  };
in {
  options.colors.catppuccin = lib.mkOption {
    type = lib.types.attrs;
    default = palette;
    description = "The complete Catppuccin color palette structure.";
  };
  config = {
    catppuccin = catppuccinCfg;
    home-manager.users."${userCfg.userName}" = { catppuccin = catppuccinCfg; };
  };
}
