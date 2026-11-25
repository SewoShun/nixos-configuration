{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.my.services.yaskkserv2;
  inherit (config.my.constants) username;
in
{
  options.my.services.yaskkserv2.enable = lib.mkEnableOption "yaskkserv2";

  config = lib.mkMerge [
    {
      home-manager.users.${username}.imports = [ inputs.yaskkserv2-nix.homeModules.yaskkserv2 ];
    }
    (lib.mkIf cfg.enable {
      home-manager.users.${username}.services.yaskkserv2 = {
        enable = true;
        jisyo = with pkgs; [
          skkDictionaries.l
          skkDictionaries.propernoun
          skkDictionaries.jinmei
          skkDictionaries.fullname
          skkDictionaries.geo
        ];
      };
    })
  ];
}
