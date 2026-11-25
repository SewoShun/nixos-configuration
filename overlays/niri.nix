{ config, inputs, ... }:
let
  inherit (config.my.constants) username;
in
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  home-manager.users.${username}.nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
