{ pkgs, ... }:

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
      rebuild = "sudo nixos-rebuild switch --flake /home/mkaraffa/nixos-config#sharktopus";
      update = "nix flake update /home/mkaraffa/nixos-config";
      gs = "git status";
    };
  };

  # Add your per-user packages and dotfiles here.
  home.packages = with pkgs; [ claude-code ];

  # Setting firefox as default browser
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  # Helps CLI tools pick firefox
  home.sessionVariables.BROWSER = "firefox";

}
