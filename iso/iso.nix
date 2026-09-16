{
  onixModule,
  nixpkgs,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    onixModule
    {
      onix.profile = "server";
      system.stateVersion = "26.05";
      services.openssh.enable = nixpkgs.lib.mkForce false;
    }
  ];
}