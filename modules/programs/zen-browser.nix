{ delib, inputs, ... }:
delib.module {
  name = "programs.zen-browser";

  options = delib.singleEnableOption false;

  home.always.imports = [ inputs.zen-browser.homeModules.beta ];

  home.ifEnabled.programs.zen-browser = {
    enable = true;

    profiles.default.settings = {
      "intl.locale.requested" = "ja";
      "intl.accept_languages" = "ja, en-us, en;q=0.5";
    };
  };
}
