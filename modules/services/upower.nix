{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.upower;
in
{
  options.my.services.upower.enable = lib.mkEnableOption "upower";

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
  };
}
