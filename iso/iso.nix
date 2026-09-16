{
  pkgs,
  nixpkgs,
  onixModule,
  system,
  ...
}:
pkgs.lib.nixosSystem {
  inherit system;
  modules = [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    onixModule
    {
      onix.profile = "server";
      system.stateVersion = "26.05";
      services.openssh.enable = pkgs.lib.mkForce false;
    }
  ];
}