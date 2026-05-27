{ delib, pkgs, ... }:
delib.host {
  name = "thinkpad-e14-gen7";

  displays = [
    {
      name = "eDP-1";
      refreshRate = 60;
      width = 1920;
      height = 1200;
      x = 0;
      y = 0;
    }
  ];

  myconfig =
    { name, ... }:
    {
      args.shared.hostName = name;

      hardware = {
        cpu.amd.enable = true;
        gpu.amd.enable = true;
        ssd.enable = true;
        bluetooth.enable = true;
        laptop.enable = true;
      };

      swap.enable = true;

      boot = {
        zswap.enable = true;
        limine = {
          enable = true;
          secureBoot = true;
          extraEntries = ''
            /Windows
              protocol: efi
              path: uuid(4e81a813-74af-453c-a204-8141bcaade72):/EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
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
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      kernelParams = [
        "acpi_backlight=native"
        "iommu=soft"
        "resume_offset=16377208"
      ];
      resumeDevice = "/dev/disk/by-uuid/769e63fb-d3c5-4819-a5a1-10a2bd0a9cb6";
    };
  };
}
