{ delib, pkgs, ... }:
delib.module {
  name = "programs.steam";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
