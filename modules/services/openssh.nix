{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.openssh;
in
{
  options.my.services.openssh.enable = lib.mkEnableOption "openssh";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
