{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.onix.profile == "gnome") {
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    papirus-icon-theme
  ];
}