{ config, lib, ... }:
let
  cfg = config.my.user;
  inherit (config.my.constants) username;
in
{
  options.my.user = {
    defaultUserShell = lib.mkOption {
      type = lib.types.either lib.types.package lib.types.path;
      default = "/bin/sh";
    };
  };

  config = {
    users = {
      inherit (cfg) defaultUserShell;

      groups.${username} = { };

      users.${username} = {
        hashedPasswordFile = config.age.secrets.password.path;
        isNormalUser = true;
        extraGroups = [
          "audio"
          "networkmanager"
          "seat"
          "wheel"
        ];
      };
    };
  };
}
