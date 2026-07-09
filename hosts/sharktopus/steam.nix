{ pkgs, ... }:

{
  # Steam + Proton (Proton-GE for better game compatibility) and GameMode.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.gamemode.enable = true;
}
