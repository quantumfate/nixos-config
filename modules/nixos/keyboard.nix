{ config, pkgs, ... }:

let layoutName = "real-prog-dvorak";
in {
  # https://github.com/ThePrimeagen/keyboards
  # https://www.reddit.com/r/NixOS/comments/1lf67uq/creating_a_custom_keyboard_layout_in_nix/ 
  config = {
    environment.systemPackages = with pkgs; [ qmk dos2unix ];
    hardware.keyboard.qmk.enable = true;

    services.xserver = {
      xkb.layout = layoutName;
      xkb.variant = layoutName;
      xkb.extraLayouts.${layoutName} = rec {
        languages = [ "eng" "deu" ];
        description = "Programmers Dvorak with custom AltGr maps";
        symbolsFile = builtins.toFile "symbols-${layoutName}" ''
          partial alphanumeric_keys
          xkb_symbols "${layoutName}" {
              include "pc"
              include "inet(evdev)"
              include "us"

              name[Group1]= "English (Real Programmers Dvorak)";

              key <TLDE> { [       dollar,        asciitilde, dead_grave, dead_tilde      ] };

              key <AE01> { [          plus,       1               ]       };
              key <AE02> { [          bracketleft,        2               ]       };
              key <AE03> { [          braceleft,  3       ]       };
              key <AE04> { [          parenleft,  4               ]       };
              key <AE05> { [          ampersand,      5               ]       };
              key <AE06> { [          equal,  6, dead_circumflex, dead_circumflex ]   };
              key <AE07> { [          parenright, 7       ]       };
              key <AE08> { [          braceright, 8       ]       };
              key <AE09> { [          bracketright,       9,  dead_grave] };
              key <AE10> { [          asterisk,   0       ]       };
              key <AE11> { [ exclam,      percent ]       };
              key <AE12> { [ bar, grave,  dead_tilde] };

              key <AD01> { [  semicolon,  colon, dead_acute, dead_diaeresis       ] };
              key <AD02> { [      comma,  less,   dead_cedilla, dead_caron        ] };
              key <AD03> { [      period, greater, dead_abovedot, periodcentered  ] };
              key <AD11> { [      slash,  question        ]       };
              key <AD12> { [      at,     asciicircum             ]       };

              key <AC11> { [      minus,  underscore      ]       };

              key <AB01> { [   apostrophe,        quotedbl, dead_ogonek, dead_doubleacute ] };

              key <BKSL> { [  backslash,  numbersign             ]       };
              
              include "level3(ralt_switch)"
          };
        '';
      };
    };
  };
}
