{ delib, inputs, ... }:
delib.module {
  name = "services.xremap";

  options = delib.singleEnableOption false;

  nixos.always.imports = [ inputs.xremap.nixosModules.default ];

  nixos.ifEnabled.services.xremap = {
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
}
