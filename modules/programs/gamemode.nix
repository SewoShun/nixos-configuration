{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.gamemode;
in
{
  options.my.programs.gamemode.enable = lib.mkEnableOption "gamemode";

  config = lib.mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };
}
