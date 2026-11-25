{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hardware.ssd;
in
{
  options.my.hardware.ssd.enable = lib.mkEnableOption "ssd";

  config = lib.mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}
