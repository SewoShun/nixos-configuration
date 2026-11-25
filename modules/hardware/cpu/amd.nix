{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hardware.cpu.amd;
in
{
  options.my.hardware.cpu.amd.enable = lib.mkEnableOption "amd";

  config = lib.mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = true;
  };
}
