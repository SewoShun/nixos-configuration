{ delib, pkgs, ... }:
delib.module {
  name = "programs.starship";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      env_var = {
        GHQ_LOOK = {
          format = "ghq look: [$env_value]($style) ";
        };
      };
      custom.jj = {
        command = "prompt";
        format = "$output";
        ignore_timeout = true;
        shell = [
          "${pkgs.starship-jj}/bin/starship-jj"
          "--ignore-working-copy"
          "starship"
        ];
        use_stdin = false;
        when = true;
      };
    };
  };
}
