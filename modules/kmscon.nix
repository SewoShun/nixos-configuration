{ delib, ... }:
delib.module {
  name = "services.kmscon";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.kmscon = {
    enable = true;
    config.font-name = "ZedMono Nerd Font";
  };
}
