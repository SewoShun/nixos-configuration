{ delib, ... }:
delib.module {
  name = "nixpkgs";

  nixos.always.nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  home.always.nixpkgs.config.allowUnfree = true;
}
