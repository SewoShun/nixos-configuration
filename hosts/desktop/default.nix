{ delib, pkgs, ... }:

delib.host {
  name = "desktop";

  displays = [
    {
      name = "HDMI-A-1";
      refreshRate = 60;
      width = 1920;
      height = 1080;
      x = 3440;
      y = 0;
    }
    {
      name = "DP-1";
      refreshRate = 60;
      width = 3440;
      height = 1440;
      x = 0;
      y = 0;
    }
  ];

  myconfig =
    { name, ... }:
    {
      args.shared.hostName = name;

      hardware = {
        cpu.intel.enable = true;
        gpu.nvidia.enable = true;
        ssd.enable = true;
        bluetooth.enable = true;
      };

      swap.enable = true;

      boot = {
        zswap.enable = true;
        limine.enable = true;
      };

      xdg-portal.enable = true;

      features = {
        nix-enhancement.enable = true;
        cli.enable = true;
        gui.enable = true;
      };

      services = {
        flatpak.enable = true;
        ollama.enable = true;
        openssh.enable = true;
        pipewire.enable = true;
        tailscale.enable = true;
        xremap.enable = true;
      };

      programs = {
        claude-code.enable = true;
      };
    };

  nixos = {
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };
}
