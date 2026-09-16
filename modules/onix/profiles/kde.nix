{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.onix.profile == "kde") {
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  environment.systemPackages = with pkgs; [
    kio-admin
    plasma-browser-integration
    papirus-icon-theme
  ];
}