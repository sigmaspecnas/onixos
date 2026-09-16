{
  description = "oNixOs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      onixModule = import ./modules/onix/default.nix;

      onixosSystem = args:
        nixpkgs.lib.nixosSystem {
          system = system;
          modules = [ onixModule ] ++ (args.modules or [ ]);
        };

      installIso = (import ./iso/iso.nix {
        inherit pkgs nixpkgs onixModule system;
      }).config.system.build.isoImage;
    in
    {
      nixosModules.onixos = onixModule;
      lib.onixosSystem = onixosSystem;
      nixosConfigurations.onixos = onixosSystem { };
      packages.${system}.default = installIso;
    };
}