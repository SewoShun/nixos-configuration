{ config, lib, ... }:
let
  cfg = config.my.swap;
in
{
  options.my.swap = {
    enable = lib.mkEnableOption "swap";
    devices = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [
        {
          device = "/swapfile";
          size = 32 * 1024;
        }
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    swapDevices = cfg.devices;
  };
}
