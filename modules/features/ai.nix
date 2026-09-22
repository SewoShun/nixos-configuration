{
  delib,
  pkgs,
  inputs,
  ...
}:
let
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
delib.module {
  name = "features.ai";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = { myconfig, ... }: {
    programs = {
      mcp.enable = true;
      claude-code.enable = myconfig.features.cli.enable;
    };
    services.ollama.enable = myconfig.features.cli.enable;
  };

  home.ifEnabled = { myconfig, ... }: {
    home.packages =
      with pkgs;
      [ sentrux ]
      ++ (
        if myconfig.features.gui.enable then
          [
            claudeDesktop
            libGL
          ]
        else
          [ ]
      );
  };
}
