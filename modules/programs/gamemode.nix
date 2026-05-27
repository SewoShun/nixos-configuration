{ delib, pkgs, ... }:
delib.module {
  name = "programs.gamemode";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.gamemode = {
    enable = true;
    settings = {
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
}
