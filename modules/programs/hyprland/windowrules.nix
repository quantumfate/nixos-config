{ config, ... }:

let userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 1, match:class code"
          "workspace 3, center on, content game, fullscreen_state 0 0, decorate off, opacity 1.0 override, no_anim on, match:class Dofus.x64"
          "workspace 3, center on, match:class Ankama Launcher, match:title overlay"
          "workspace 3, fullscreen_state 2 2, match:class steam_app_\\d+"

          # Special Workspaces
          #"workspace special:gaming, match:class (steam)"
          #"workspace special:keepass, match:class (org\\.keepassxc\\.KeePassXC)"
          #"workspace special:ankama, match:class Ankama Launcher, match:title Ankama Launcher"
          #"workspace special:vesktop, match:class vesktop"
          #"workspace special:spotify, match:class spotify"
          #"workspace special:obs, match:initial_class com.obsproject.Studio"
          #"workspace special:whatsapp-electron, match:initial_class whatsapp-electron"

          "no_initial_focus on, match:class (steam|vesktop|whatsapp-electron)"
          "suppress_event activatefocus, match:class (steam|vesktop|whatsapp-electron)"
          "move 300 400, match:title Friends List"
          "move 600 600, match:title Launching..."

          # Specific Application Settings
          "float on, match:class (xdg-desktop-portal-gtk|xdg-desktop-portal-hyprland)"
          "float on, match:title (Steam Settings|Friends List|Library)"
          "size 800 400, match:title Library"
          "tag +pip, match:initial_title Discord Popout"
          "float on, match:class (ffplay)"
          "size 600 400, match:class (xdg-desktop-portal-gtk|xdg-desktop-portal-hyprland)"
          "float on, match:class (clipse)"
          "size 800 600, match:class (clipse)"

          # Browsers
          "tag +chromium-based-browser, match:class ((google-)?[cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable|helium)"
          "tag +firefox-based-browser, match:class ([fF]irefox|zen|librewolf|zen-twilight)"
          "tile on, match:tag chromium-based-browser"

          # Picture-in-picture overlays
          "tag +pip, match:title (Picture.?in.?[Pp]icture)"
          "float on, match:tag pip"
          "pin on, match:tag pip"
          "size 600 338, match:tag pip"
          "keep_aspect_ratio on, match:tag pip"
          "border_size 0, match:tag pip"
          "opacity 1 1 override, match:tag pip"
          "move 100%-w-40 4%, match:tag pip"

          # Floating windows
          "float on, match:tag floating-window"
          "center on, match:tag floating-window"
          "size 900 700, match:tag floating-window"

          "tag +floating-window, match:class (Impala|About|bluetui|Wiremix|com.gabm.satty|Calos|About|TUI.float|io\\.github\\.Qalculate\\.qalculate-qt)"
          "tag +floating-window, match:class (xdg-desktop-portal-hyprland|xdg-desktop-portal-gtk|sublime_text|DesktopEditors), match:title (Open.*Files?|Save.*Files?|Save.*As|All Files|Save)"
          "tag +floating-window, match:class (zen|zen-twilight), match:title (Library)"
          "tag +floating-window, match:class (org\\.keepassxc\\.KeePassXC), match:title (Unlock Database - KeePassXC)"

          # No transparency on media windows
          "opacity 1 1, match:class ^(zoom|vlc|mpv|mp4|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$"

          # Define terminal tag to style them uniformly
          "tag +terminal, match:class (Alacritty|kitty|ghostty|foot)"

        ];
        layerrule = [ "match:namespace notifications, animation slide" ];
      };
    };
  };
}
