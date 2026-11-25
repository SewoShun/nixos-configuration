{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.awww;
  inherit (config.my.constants) username;
in
{
  options.my.services.awww.enable = lib.mkEnableOption "awww";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.services.awww.enable = true;
  };
}
