{ delib, ... }:
delib.module {
  name = "boot.zswap";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.boot.zswap.enable = true;
}
