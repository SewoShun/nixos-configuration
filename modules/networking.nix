{ delib, ... }:
delib.module {
  name = "networking";

  nixos.always = {
    networking = {
      firewall.enable = true;
      iproute2.enable = true;
      networkmanager = {
        enable = true;
        wifi.powersave = false;
      };
    };
    services.resolved.enable = true;
  };
}
