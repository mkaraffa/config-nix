{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    settings.user.name = "Matt";
    settings.user.email = "mkaraffa@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      # NixOS management
      rebuild = "sudo nixos-rebuild switch --flake /home/mkaraffa/nixos-config#$(hostname)";
      update = "nix flake update /home/mkaraffa/nixos-config";
      # Git
      gs = "git status";
      # Navigation / listing
      l = "ls";
      ll = "ls -lh";
      lrt = "ls -rt1";
      lart = "ls -larth";
      # Convenience
      m = "more";
      mroe = "more";
      h = "history";
      hh = "history | tail -15";
      untar = "tar -xvzf";
      # Typo aliases
      givm = "gvim";
      # Launch firefox detached from terminal
      ff = "( firefox ) >& /dev/null &";
    };
  };

  home.file.".vimrc".text = ''
    set guifont=Inconsolata\ Medium\ 14
    set nomodeline

    set tabstop=8
    set softtabstop=2
    set shiftwidth=2
    set expandtab

    set autoindent
    set number
    set ignorecase
    syntax on
    filetype on
    colorscheme slate
    set hlsearch
  '';

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];
      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };
  };

  home.packages = with pkgs; [
    claude-code
    fastfetch
    tmux
    nil
    bash-language-server
    wl-clipboard
  ];

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
