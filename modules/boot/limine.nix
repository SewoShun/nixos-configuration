{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.boot.limine;
in
{
  options.my.boot.limine = {
    enable = lib.mkEnableOption "limine";
    secureBoot = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    extraEntries = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = false;
      limine = {
        enable = true;
        maxGenerations = 8;
        secureBoot.enable = cfg.secureBoot;
        inherit (cfg) extraEntries;
      };
    };

    environment.systemPackages = [ pkgs.sbctl ];
  };
}
