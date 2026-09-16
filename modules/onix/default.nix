{
  config,
  lib,
  ...
}:
let
  profiles = {
    gnome = ./profiles/gnome.nix;
    kde = ./profiles/kde.nix;
    hyprland = ./profiles/hyprland.nix;
    server = ./profiles/server.nix;
  };
in
{
  options.onix.profile = lib.mkOption {
    type = lib.types.enum (lib.attrNames profiles);
    default = "gnome";
    description = "Profile installed by default";
  };

  imports =
    [
      ./branding.nix
      ./defaults.nix
      ./packages.nix
    ]
    ++ [
      profiles.${config.onix.profile}
    ];
}