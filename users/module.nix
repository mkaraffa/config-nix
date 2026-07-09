{ config, lib, ... }@inputs:
let
  enable = config.users.local;
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhU+TU8ZL+wofNQHb+OCpqUPr0PxRgifoSWHkDcBQng mac"
  ];
in
{
  options.users.local = lib.mkOption {
    default = true;
    example = false;
    type = lib.types.bool;
    description = "Whether to install the standard site users.";
  };

  config = lib.mkIf enable {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    users.users.mkaraffa = import mkaraffa/user.nix inputs;
    users.users.root.openssh.authorizedKeys.keys = sshKeys;

    home-manager.users.mkaraffa = import mkaraffa/home.nix;
  };
}
