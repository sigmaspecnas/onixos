{
  description = "oNixOs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
    let
      onixModule = import ./modules/onix/default.nix;

      onixosSystem = args:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ onixModule ]
            ++ (args.modules or []);
        };

      installIso = import ./iso/iso.nix {
        inherit nixpkgs onixModule;
      }.config.system.build.isoImage;
    in
    {
      nixosModules.onixos = onixModule;
      lib.onixosSystem = onixosSystem;
      nixosConfigurations.onixos = onixosSystem { };
      packages.x86_64-linux.default = installIso;
    };
}