{ delib, ... }:
delib.module {
  name = "services.tailscale";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.tailscale = {
    enable = true;
  };
}
