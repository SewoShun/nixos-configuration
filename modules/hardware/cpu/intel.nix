{ delib, ... }:
delib.module {
  name = "hardware.cpu.intel";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.hardware.cpu.intel.updateMicrocode = true;
}
