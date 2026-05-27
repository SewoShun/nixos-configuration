{ delib, ... }:
delib.module {
  name = "hardware.gpu.amd";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    hardware = {
      amdgpu.initrd.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
