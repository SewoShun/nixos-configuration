{ delib, ... }:
delib.module {
  name = "services.lemurs";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.displayManager.lemurs.enable = true;
}
