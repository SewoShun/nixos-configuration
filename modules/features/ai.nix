{
  delib,
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
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
            inputs.claude-desktop.packages.${system}.default
            libGL
          ]
        else
          [ ]
      );
  };
}
