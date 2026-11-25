{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.my.services.xremap;
in
{
  imports = [
    inputs.xremap.nixosModules.default
  ];

  options.my.services.xremap.enable = lib.mkEnableOption "xremap";

  config = lib.mkIf cfg.enable {
    services.xremap = {
      enable = true;
      config.modmap = [
        {
          name = "Replace CapsLock to LeftControll";
          remap = {
            "CapsLock" = "Ctrl_L";
          };
        }
      ];
    };
  };
}
