{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.tailscale;
in
{
  options.my.services.tailscale.enable = lib.mkEnableOption "tailscale";

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscale-auth-key.path;
      extraUpFlags = [ "--ssh" ];
    };
  };
}
