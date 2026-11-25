{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.ollama;
  inherit (config.my.constants) username;
in
{
  options.my.services.ollama.enable = lib.mkEnableOption "ollama";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.services.ollama.enable = true;
  };
}
