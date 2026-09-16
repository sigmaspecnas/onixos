{
  lib,
  ...
}:
{
  options.onix.profile = lib.mkOption {
    type = lib.types.enum [
      "gnome"
      "kde"
      "hyprland"
      "server"
    ];
    default = "gnome";
    description = "Profile applied to the system";
  };

  imports = [
    ./branding.nix
    ./defaults.nix
    ./packages.nix
    ./tools.nix
    ./profiles/gnome.nix
    ./profiles/kde.nix
    ./profiles/hyprland.nix
    ./profiles/server.nix
  ];
}