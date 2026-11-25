{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.dunst;
  inherit (config.my.constants) username;
in
{
  options.my.services.dunst.enable = lib.mkEnableOption "dunst";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.services.dunst.enable = true;
  };
}
