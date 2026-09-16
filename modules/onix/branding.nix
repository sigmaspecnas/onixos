{
  config,
  lib,
  pkgs,
  ...
}:
let
  asciiArt = builtins.readFile ../../assets/ascii-art.txt;
  onix-banner = pkgs.writeShellScriptBin "onix-banner" "cat /etc/onix/ascii-art.txt";
in
{
  system.nixos.distroId = "onixos";
  system.nixos.distroName = "oNixOs";
  system.nixos.tags = [ ];
  system.stateVersion = lib.mkDefault "26.05";

  environment.etc."motd".text = asciiArt;

  environment.etc."onix/ascii-art.txt".text = asciiArt;
  environment.etc."onix/icon.svg".source = ../../assets/icon2.svg;

  environment.systemPackages = [ onix-banner ];

  boot.loader.grub.splashImage = lib.mkDefault ../../assets/icon.png;

  boot.plymouth = {
    enable = lib.mkDefault true;
    theme = lib.mkDefault "bgrt";
  };
}