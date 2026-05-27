{ delib, pkgs, ... }:
delib.module {
  name = "features.cli";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    user.defaultUserShell = pkgs.fish;

    services.pueue.enable = true;

    programs = {
      bat.enable = true;
      delta.enable = true;
      direnv.enable = true;
      eza.enable = true;
      fish.enable = true;
      gh.enable = true;
      git.enable = true;
      helix.enable = true;
      jujutsu.enable = true;
      ripgrep.enable = true;
      skim.enable = true;
      starship.enable = true;
      yazi.enable = true;
      zellij.enable = true;
      zoxide.enable = true;
    };
  };

  nixos.ifEnabled.environment.defaultPackages = with pkgs; [
    rip2
    wl-clipboard-rs
  ];

  home.ifEnabled = {
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
      bottom.enable = true;
      docker-cli.enable = true;
    };
  };
}
