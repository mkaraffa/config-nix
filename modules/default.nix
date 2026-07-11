{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # External modules
    inputs.home-manager.nixosModules.default
    # Local modules
    ./desktop.nix
  ];

  config = {
    nixpkgs.config.allowUnfree = true;

    # Nix / flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nix.optimise.automatic = true;
    nix.gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 14d";
    };

    # Locality
    time.timeZone = lib.mkDefault "America/New_York"; # override per host if needed
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

    # SSH — key auth plus a first-boot password fallback. Harden later by setting
    # PasswordAuthentication = false once key login is confirmed.
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = true;
      };
    };

    environment.systemPackages = with pkgs; [
      vim-full
      git
      curl
      efibootmgr
      pciutils
      usbutils
      htop
    ];
  };
}
