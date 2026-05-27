{ delib, config, ... }:
delib.module {
  name = "hardware.gpu.nvidia";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    boot.initrd.availableKernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    hardware.nvidia = {
      forceFullCompositionPipeline = true;
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
