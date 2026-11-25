{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.nordvpn;
in
{
  options.my.services.nordvpn.enable = lib.mkEnableOption "nordvpn";

  config = lib.mkIf cfg.enable {
    networking = {
      wg-quick.interfaces.nordvpn = {
        autostart = true;
        address = [ "10.5.0.2/32" ];
        dns = [
          "103.86.96.100"
          "103.86.99.100"
        ];
        privateKeyFile = config.age.secrets.nordvpn-wg-key.path;
        mtu = 1420;

        peers = [
          {
            publicKey = "SAio0Z0suFlRfmydzPdcn6MamqS7Mq4pSOm2YmJkLSs=";
            endpoint = "jp786.nordvpn.com:51820";
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            persistentKeepalive = 10;
          }
        ];
      };

      networkmanager.unmanaged = [ "type:wireguard" ];
    };
  };
}
