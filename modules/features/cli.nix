{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.features.cli;
  inherit (config.my.constants) username;
  homeConfig = config.home-manager.users.${username};
in
{
  options.my.features.cli.enable = lib.mkEnableOption "cli";

  config = lib.mkIf cfg.enable {
    my = {
      user.defaultUserShell = homeConfig.programs.nushell.package;

      services.pueue.enable = true;

      programs = {
        bat.enable = true;
        delta.enable = true;
        direnv.enable = true;
        eza.enable = true;
        fd.enable = true;
        fish.enable = true;
        gh.enable = true;
        git.enable = true;
        helix.enable = true;
        jujutsu.enable = true;
        nushell.enable = true;
        ripgrep.enable = true;
        skim.enable = true;
        starship.enable = true;
        yazi.enable = true;
        zoxide.enable = true;
      };
    };

    environment.defaultPackages = with pkgs; [
      rip2
      wl-clipboard-rs
    ];

    home-manager.users.${username} = {
      home.packages = with pkgs; [
        ghq
        gping
        just
        procs
        rip2
        tokei
        wl-clipboard-rs
      ];

      programs = {
        carapace.enable = true;
        bottom.enable = true;
        docker-cli.enable = true;
      };
    };
  };
}
