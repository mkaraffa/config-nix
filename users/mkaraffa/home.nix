{ ... }:

{
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    userName = "Matt";
    userEmail = "mkaraffa@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/mkaraffa/nix-config#sharktopus";
      update = "nix flake update /home/mkaraffa/nix-config";
      gs = "git status";
    };
  };

  # Add your per-user packages and dotfiles here.
  home.packages = [ ];
  
}
