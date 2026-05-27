{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "services.yaskkserv2";

  options = delib.singleEnableOption false;

  home.always.imports = [ inputs.yaskkserv2-nix.homeModules.yaskkserv2 ];

  home.ifEnabled.services.yaskkserv2 = {
    enable = true;
    jisyo = with pkgs; [
      skkDictionaries.l
      skkDictionaries.propernoun
      skkDictionaries.jinmei
      skkDictionaries.fullname
      skkDictionaries.geo
    ];
  };
}
