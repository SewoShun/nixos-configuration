{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hardware.gpu.amd;
in
{
  options.my.hardware.gpu.amd.enable = lib.mkEnableOption "amd";

  config = lib.mkIf cfg.enable {
    hardware = {
      amdgpu.initrd.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
