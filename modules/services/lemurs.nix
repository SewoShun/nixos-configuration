{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.lemurs;
in
{
  options.my.services.lemurs.enable = lib.mkEnableOption "lemurs";

  config = lib.mkIf cfg.enable {
    services.displayManager.lemurs.enable = true;
  };
}
