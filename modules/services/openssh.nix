{ delib, ... }:
delib.module {
  name = "services.openssh";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
