{ ... }:

{
  imports = [
    ./hardware-configuration.nix # generated on the box: nixos-generate-config
    ./steam.nix
  ];

  # ---------------------------------------------------------------------------
  # Bootloader — systemd-boot on the SHARED 300 MB ESP (nvme0n1p1). Auto-detects
  # Windows (/EFI/Microsoft/Boot/bootmgfw.efi). Do NOT reformat the ESP.
  # Secure Boot is disabled in BIOS; to keep it on later, adopt lanzaboote the
  # way etherealwake does.
  # ---------------------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5; # ESP is small (300 MB)
  boot.loader.timeout = 5; # show menu when a monitor's attached
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sharktopus";
  networking.networkmanager.enable = true;

  time.hardwareClockInLocalTime = true; # dual-boot clock fix (Windows uses localtime)
  time.timeZone = "America/Los_Angeles";

  # Turn on the shared desktop module (GNOME + graphics + audio).
  local.desktop.enable = true;

  services.fstrim.enable = true;

  system.stateVersion = "26.05"; # match the release you installed
}
