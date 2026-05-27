{ delib, ... }:
delib.module {
  name = "services.pipewire";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    pulse.enable = true;
  };
}
