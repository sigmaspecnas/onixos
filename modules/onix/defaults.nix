{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.onix = {
    enableFlatpak = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    gpu = lib.mkOption {
      type = lib.types.enum [
        "auto"
        "intel"
        "amd"
        "nvidia"
      ];
      default = "auto";
    };
  };

  config = lib.mkMerge [
    {
      system.stateVersion = "26.05";

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      boot.kernelParams = [ "nohz=off" ];

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        firefox
        wineWow64Packages.stable
        git
        vscode
        curl
        wget
        htop
        fastfetch
        pciutils
        usbutils
      ];

      services.flatpak.enable = config.onix.enableFlatpak;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };

      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        dejavu_fonts
      ];

      hardware.graphics.enable = true;

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    }

    (lib.mkIf (config.onix.gpu == "nvidia") {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
      };
    })

    (lib.mkIf (config.onix.gpu == "amd") {
      services.xserver.videoDrivers = [ "amdgpu" ];
    })
  ];
}