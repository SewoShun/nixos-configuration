{ delib, inputs, ... }:
delib.module {
  name = "services.flatpak";

  options = delib.singleEnableOption false;

  home.always.imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  home.ifEnabled.services.flatpak.enable = true;
}
