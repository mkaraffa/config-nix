{ ... }:

{
  home.stateVersion = "25.11";

  programs.git = {
    enable = true;
    userName = "Matt";
    userEmail = "mkaraffa@gmail.com";
  };

  # Add your per-user packages and dotfiles here.
  home.packages = [ ];
}
