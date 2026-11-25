{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.angrr;
in
{
  options.my.services.angrr.enable = lib.mkEnableOption "angrr";

  config = lib.mkIf cfg.enable {
    services.angrr = {
      enable = true;
      enableNixGcIntegration = true;
      settings = {
        temporary-root-policies = {
          direnv = {
            path-regex = "/\\.direnv/";
            period = "14d";
          };
          result = {
            path-regex = "/result[^/]*$";
            period = "3d";
          };
        };
      };
    };
  };
}
