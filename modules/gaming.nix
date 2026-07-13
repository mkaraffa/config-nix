{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.gaming;
in
{
  options.local.gaming = {
    enable = lib.mkEnableOption "the Steam gaming stack";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
