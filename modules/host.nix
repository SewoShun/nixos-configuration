{ config, lib, ... }:
{
  options.my.host.displays = lib.mkOption {
    type = lib.types.listOf (
      lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          name = lib.mkOption { type = lib.types.str; };
          primary = lib.mkOption {
            type = lib.types.bool;
            default = builtins.length config.my.host.displays == 1;
          };
          touchscreen = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          refreshRate = lib.mkOption {
            type = lib.types.int;
            default = 60;
          };
          width = lib.mkOption {
            type = lib.types.int;
            default = 1920;
          };
          height = lib.mkOption {
            type = lib.types.int;
            default = 1080;
          };
          x = lib.mkOption {
            type = lib.types.int;
            default = 0;
          };
          y = lib.mkOption {
            type = lib.types.int;
            default = 0;
          };
        };
      }
    );
    default = [ ];
  };
}
