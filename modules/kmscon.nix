{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.kmscon;
in
{
  options.my.services.kmscon.enable = lib.mkEnableOption "kmscon";

  config = lib.mkIf cfg.enable {
    services.kmscon = {
      enable = true;
      config.font-name = "ZedMono Nerd Font";
    };
  };
}
