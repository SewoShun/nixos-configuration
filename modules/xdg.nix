{
  config,
  lib,
  ...
}:
let
  cfg = config.my.xdg-portal;
  inherit (config.my.constants) username;
in
{
  options.my.xdg-portal.enable = lib.mkEnableOption "xdg-portal";

  config = lib.mkIf cfg.enable {
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];

    home-manager.users.${username}.xdg.portal.enable = true;
  };
}
