{
  pkgs,
  nixpkgs,
  onixModule,
  system,
  ...
}:
let
  onix-installer = pkgs.writeTextFile {
    name = "onix-installer";
    text = builtins.readFile ../installer/onix-installer;
    executable = true;
    destination = "/bin/onix-installer";
  };
in
pkgs.lib.nixosSystem {
  inherit system;
  modules = [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    onixModule
    {
      onix.profile = "server";
      system.stateVersion = "26.05";
      services.openssh.enable = nixpkgs.lib.mkForce false;
    }
    {
      environment.systemPackages = [
        onix-installer
        pkgs.python3
        pkgs.parted
        pkgs.btrfs-progs
        pkgs.xfsprogs
      ];
      environment.etc."onix/templates/modules".source = ../modules;
    }
  ];
}