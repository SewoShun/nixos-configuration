{
  delib,
  pkgs,
  lib,
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
      services.greetd = {
        enable = true;
        settings.default_session = lib.mkIf (cfg.greeter == "tuigreet") {
          user = "sewo";
          command = "${lib.getExe pkgs.tuigreet} --time --cmd niri-session";
        };
      };

      # programs.regreet sets services.greetd.settings.default_session.command
      programs.regreet = lib.mkIf (cfg.greeter == "regreet") {
        enable = true;
        cageArgs = [
          "-s"
          "-mlast"
        ];
        settings.background = {
          path = pkgs.nixos-artwork.wallpapers.catppuccin-mocha.gnomeFilePath;
          fit = "Cover";
        };
      };
    };
}
