{
  config,
  lib,
  ...
}:
let
  cfg = config.my.services.pipewire;
in
{
  options.my.services.pipewire.enable = lib.mkEnableOption "pipewire";

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
