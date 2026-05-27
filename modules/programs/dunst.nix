{ delib, ... }:
delib.module {
  name = "services.dunst";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.dunst.enable = true;
}
