{ delib, ... }:
delib.module {
  name = "boot";

  nixos.always.boot.loader.efi.canTouchEfiVariables = true;
}
