{ delib, ... }:
delib.module {
  name = "hardware.bluetooth";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.hardware.bluetooth.enable = true;
}
