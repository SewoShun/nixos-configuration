{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.pueue;
  inherit (config.my.constants) username;
in
{
  options.my.services.pueue.enable = lib.mkEnableOption "pueue";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.services.pueue.enable = true;
  };
}
