{ delib, ... }:
delib.module {
  name = "programs.direnv";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = ''
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
        echo /tmp/direnv/$(pwd | base64)
      }
    '';
  };
}
