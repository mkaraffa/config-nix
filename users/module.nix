{ config, lib, ... }@inputs:
let
  cfg = config.local.users;
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhU+TU8ZL+wofNQHb+OCpqUPr0PxRgifoSWHkDcBQng mac"
  ];
in
{
  options.local.users = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to install the standard site users.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.backupFileExtension = "backup";
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    users.users.mkaraffa = (import mkaraffa/user.nix inputs) // {
      openssh.authorizedKeys.keys = sshKeys;
    };
    users.users.root.openssh.authorizedKeys.keys = sshKeys;

    home-manager.users.mkaraffa = import mkaraffa/home.nix;
  };
}
