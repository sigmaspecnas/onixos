{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.onix.packages =
    lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

  config = lib.mkIf (config.onix.packages != [ ]) {
    environment.systemPackages =
      map (name: pkgs.${name}) config.onix.packages;
  };
}