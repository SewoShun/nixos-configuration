{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.steam;
in
{
  options.my.programs.steam.enable = lib.mkEnableOption "steam";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      extest.enable = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
