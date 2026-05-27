{ delib, ... }:
delib.module {
  name = "programs.claude-code";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs = {
    mcp = {
      enable = true;
    };

    claude-code = {
      enable = true;
      enableMcpIntegration = true;
    };
  };
}
