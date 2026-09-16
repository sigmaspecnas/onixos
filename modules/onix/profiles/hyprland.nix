{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    waybar
    wofi
    hyprlock
    hypridle
  ];
}