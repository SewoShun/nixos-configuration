{ delib, ... }:
delib.module {
  name = "services.angrr";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.angrr = {
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
}
