{ delib, ... }:
delib.module {
  name = "security";

  nixos.always.security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo-rs.enable = true;
  };
}
