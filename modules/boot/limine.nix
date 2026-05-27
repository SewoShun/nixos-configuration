{ delib, pkgs, ... }:
delib.module {
  name = "boot.limine";

  options =
    with delib;
    moduleOptions {
      enable = boolOption false;
      secureBoot = boolOption false;
      extraEntries = strOption "";
    };

  nixos.ifEnabled =
    { cfg, ... }:
    {
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
