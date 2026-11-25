{ config, ... }:
let
  inherit (config.my.constants) username;
in
{
  home-manager.users.${username}.home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
}
