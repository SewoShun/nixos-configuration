{
  delib,
  pkgs,
  config,
  ...
}:
delib.module {
  name = "services.greetd";

  options =
    with delib;
    moduleOptions {
      enable = boolOption false;
      greeter = enumOption [ "regreet" ] "regreet";
    };

  nixos.ifEnabled =
    { cfg, ... }:
    {
      services.greetd = {
        enable = true;
        settings.default_session.command = "${pkgs.lib.getExe pkgs.cage} -s -mlast -- ${pkgs.lib.getExe config.programs.regreet.package}";
      };

      programs.regreet.enable = cfg.greeter == "regreet";
    };
}
