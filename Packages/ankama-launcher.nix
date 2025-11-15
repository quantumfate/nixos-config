{ pkgs ? import <nixpkgs> {}, lib }:

let
  name = "ankama-launcher";

  version = "3.13.18";
  src = ./ankama-launcher.AppImage;
  appimageContents = pkgs.appimageTools.extractType2 {
    inherit src version;
    pname = name;
    sha256 = "00d7db817zraw864sg873g0qr3nzn8gm23sjxbsh958wzxil2skm"; 
  };
in
pkgs.appimageTools.wrapType2 {
  pname = name;
  inherit name src version;

  execName = "ankama-launcher";

  extraPkgs = pkgs: with pkgs; [
    libglvnd
    xorg.libXScrnSaver
    xorg.libxcb
  ];

  extraInstallCommands = ''
    # Create the directory structure for applications and icons
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/256x256/apps
    install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
    sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
    install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
  '';

}