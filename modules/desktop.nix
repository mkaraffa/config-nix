{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.desktop;
in
{
  options.local.desktop = {
    enable = lib.mkEnableOption "the GNOME desktop environment";
  };

  config = lib.mkIf cfg.enable {
    boot.plymouth.enable = true;
    boot.kernelParams = [
      "quiet"
      "splash"
    ];
    # Intel Iris Xe iGPU — Mesa, no proprietary drivers.
    hardware.enableRedistributableFirmware = true;
    hardware.graphics = {
      enable = true;
      enable32Bit = true; # 32-bit libs for Steam/Proton
      extraPackages = with pkgs; [ intel-media-driver ]; # HW video decode
    };

    # GNOME. For KDE Plasma (what etherealwake uses), swap these for:
    #   services.displayManager.sddm.enable = true;
    #   services.desktopManager.plasma6.enable = true;
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.xserver.xkb.layout = "us";

    # PipeWire audio.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.firefox.enable = true;

    fonts.packages = with pkgs; [ inconsolata ];
  };
}
