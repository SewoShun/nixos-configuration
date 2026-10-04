{ delib, config, ... }:
delib.module {
  name = "services.tailscale";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale-auth-key.path;
    extraUpFlags = [ "--ssh" ];
  };
}
