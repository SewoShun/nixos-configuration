{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hardware.gpu.nvidia;
in
{
  options.my.hardware.gpu.nvidia.enable = lib.mkEnableOption "nvidia";

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [
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
