{ delib, ... }:
delib.module {
  name = "swap";

  options =
    with delib;
    moduleOptions {
      enable = boolOption false;
      devices = listOption [
        {
          device = "/swapfile";
          size = 32 * 1024;
        }
      ];
    };

  nixos.ifEnabled =
    { cfg, ... }:
    {
      swapDevices = cfg.devices;
    };
}
