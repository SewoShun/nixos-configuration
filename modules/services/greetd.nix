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
      greeter = enumOption [ "regreet" "tuigreet" ] "tuigreet";
    };

  nixos.ifEnabled =
    { cfg, ... }:
    {
      services.greetd =
        let
          commands = {
            regreet = "${pkgs.lib.getExe pkgs.cage} -s -mlast -- ${pkgs.lib.getExe config.programs.regreet.package}";
            tuigreet = "${pkgs.lib.getExe pkgs.tuigreet} --time";
          };
        in
        {
          enable = true;
          settings.default_session = {
            user = "sewo";
            command =
              if cfg.greeter == "regreet" then
                commands.regreet
              else if cfg.greeter == "tuigreet" then
                commands.tuigreet
              else
                null;
          };
        };
    };
}
