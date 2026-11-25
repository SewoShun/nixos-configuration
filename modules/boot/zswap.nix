{
  config,
  lib,
  ...
}:
let
  cfg = config.my.boot.zswap;
in
{
  options.my.boot.zswap.enable = lib.mkEnableOption "zswap";

  config = lib.mkIf cfg.enable {
    boot.zswap.enable = true;
  };
}
