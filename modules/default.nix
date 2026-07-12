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
    ./gaming.nix
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
    # Trigger GC before builds fail due to low disk space.
    nix.settings.min-free = lib.mkDefault (5 * 1024 * 1024 * 1024);
    nix.settings.max-free = lib.mkDefault (10 * 1024 * 1024 * 1024);

    # Locality
    time.timeZone = lib.mkDefault "America/New_York"; # override per host if needed
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    environment.systemPackages = with pkgs; [
      vim-full
      git
      curl
      efibootmgr
      pciutils
      usbutils
      btop
    ];
  };
}
