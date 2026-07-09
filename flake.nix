{
  description = "Matt's NixOS configuration";

  inputs = {
    # Current stable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # User account / dotfile management
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      # NixOS configurations are wired up in hosts/default.nix
      nixosConfigurations = import ./hosts inputs;
    };
}
