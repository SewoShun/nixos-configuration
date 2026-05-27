{ delib, ... }:
delib.module {
  name = "hardware.ssd";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.fstrim.enable = true;
}
