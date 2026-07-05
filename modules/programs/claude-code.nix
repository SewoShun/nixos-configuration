{ delib, ... }:
delib.module {
  name = "programs.claude-code";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs = {
    claude-code = {
      enable = true;
      enableMcpIntegration = true;
    };
  };
}
