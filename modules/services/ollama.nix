{ delib, ... }:
delib.module {
  name = "services.ollama";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.ollama.enable = true;
}
