{ delib, ... }:
delib.module {
  name = "services.awww";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.awww.enable = true;
}
