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

      environment.systemPackages = with pkgs; [
        firefox
        wineWowPackages.stable
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