{ delib, ... }:
delib.module {
  name = "hardware.cpu.amd";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.hardware.cpu.amd.updateMicrocode = true;
}
