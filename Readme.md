# TODO

- Implement preferred [hyprland workspaces](https://github.com/Duckonaut/split-monitor-workspaces)
- Implement a module to track the upstream of the nixOS color palette
- ensure screenshot path exists
- configure [Stylix](https://nix-community.github.io/stylix/index.html)
- configure potential VMs for QMK

## Prerequisites

1. ankama-launcher.AppImage must exist in `Packages/`
2. execute `nix hash file /home/user/this-directory/Packages/ankama-launcher.AppImage`
3. replace the sha256-string in `Packages/ankama-launcher.nix` with the output of the previous command


## My inspiration

- [woioeow/hyprland-dotfiles](https://github.com/woioeow/hyprland-dotfiles/tree/main)
- [abhinandh-s/catppuccin-nix](https://github.com/abhinandh-s/catppuccin-nix) I "borrowed" your code until I fully automate the process of acquiring the latest Catppuccin colorscheme