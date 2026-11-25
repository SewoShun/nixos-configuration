{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.services.greetd;
in
{
  options.my.services.greetd = {
    enable = lib.mkEnableOption "greetd";
    greeter = lib.mkOption {
      type = lib.types.enum [
        "regreet"
        "tuigreet"
      ];
      default = "tuigreet";
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.default_session = lib.mkIf (cfg.greeter == "tuigreet") {
        user = "sewo";
        command = "${lib.getExe pkgs.tuigreet} --time --cmd niri-session";
      };
      useTextGreeter = cfg.greeter == "tuigreet";
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
