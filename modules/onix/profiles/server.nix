{
  config,
  lib,
  ...
}:
lib.mkIf (config.onix.profile == "server") {
  services.openssh.enable = true;
  networking.networkmanager.enable = true;
}