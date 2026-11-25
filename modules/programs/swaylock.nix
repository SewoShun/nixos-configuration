{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.swaylock;
  inherit (config.my.constants) username;
in
{
  options.my.programs.swaylock.enable = lib.mkEnableOption "swaylock";

  config = lib.mkIf cfg.enable {
    # swaylock authenticates via PAM; without fprintd so that the password works immediately
    security.pam.services.swaylock.fprintAuth = false;

    home-manager.users.${username} = {
      programs.swaylock = {
        enable = true;
        settings = {
          image = config.my.constants.wallpaper;
          scaling = "fill";
          clock = true;
          datestr = "%Y/%m/%d";
          indicator-idle-visible = true;
          fade-in = 0.5;
        };
        package = pkgs.swaylock-effects;
      };
    };
  };
}
