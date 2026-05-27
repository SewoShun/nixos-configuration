{ delib, ... }:
delib.module {
  name = "services.pueue";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.pueue.enable = true;
}
