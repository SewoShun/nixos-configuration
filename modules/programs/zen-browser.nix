{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.my.programs.zen-browser;
  inherit (config.my.constants) username;
in
{
  options.my.programs.zen-browser.enable = lib.mkEnableOption "zen-browser";

  config = lib.mkMerge [
    {
      home-manager.users.${username}.imports = [ inputs.zen-browser.homeModules.beta ];
    }
    (lib.mkIf cfg.enable {
      home-manager.users.${username} = {
        programs.zen-browser = {
          enable = true;
          setAsDefaultBrowser = true;

          profiles.default.settings = {
            "intl.locale.requested" = "ja";
            "intl.accept_languages" = "ja, en-us, en;q=0.5";
          };
        };

        xdg.mimeApps = {
          enable = true;
          # mimeapps.list becomes read-only once managed, so keep app-registered handlers here
          defaultApplications = {
            "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
            "x-scheme-handler/claude" = "com.anthropic.Claude.desktop";
            "x-scheme-handler/slack" = "slack.desktop";
          };
        };
      };
    })
  ];
}
