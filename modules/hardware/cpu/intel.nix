{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hardware.cpu.intel;
in
{
  options.my.hardware.cpu.intel.enable = lib.mkEnableOption "intel";

  config = lib.mkIf cfg.enable {
    hardware.cpu.intel.updateMicrocode = true;
  };
}
