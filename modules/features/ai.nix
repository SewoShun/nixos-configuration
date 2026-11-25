{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.my.features.ai;
  inherit (config.my.constants) username;
  system = pkgs.stdenv.hostPlatform.system;

  claudeDesktopRaw = inputs.claude-desktop.packages.${system}.default.override {
    electron = pkgs.electron_44;
  };
  claudeDesktop = pkgs.symlinkJoin {
    name = "claude-desktop-extra-fixed";
    paths = [ claudeDesktopRaw ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude-desktop \
        --set CHROME_DEVEL_SANDBOX "${claudeDesktopRaw}/lib/claude-desktop/chrome-sandbox"
    '';
  };
in
{
  options.my.features.ai.enable = lib.mkEnableOption "ai";

  config = lib.mkIf cfg.enable {
    my = {
      programs = {
        mcp.enable = true;
        claude-code.enable = config.my.features.cli.enable;
      };
      services.ollama.enable = config.my.features.cli.enable;
    };

    home-manager.users.${username} = {
      home.packages =
        with pkgs;
        [ sentrux ]
        ++ (
          if config.my.features.gui.enable then
            [
              claudeDesktop
              libGL
            ]
          else
            [ ]
        );
    };
  };
}
