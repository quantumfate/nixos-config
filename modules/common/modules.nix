{ lib, ... }:

{
  options.common.modules = {
    _options = lib.mkOption {
      default = {};
      description = "Configuration options to enable certain modules.";
    };
    
    nvidia.enable = lib.mkEnableOption "Enable the Nvidia module.";
    steam.enable = lib.mkEnableOption "Enable the Steam module.";
    dofus.enable = lib.mkEnableOption "Enable the Dofus module.";  
    bluetooth.enable = lib.mkEnableOption "Enable the Bluetooth module with blueman-applet.";
    qmk.enable = lib.mkEnableOption "Enable installation of QMK.";
  };
}