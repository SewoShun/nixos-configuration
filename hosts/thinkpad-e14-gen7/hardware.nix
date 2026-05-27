{
  delib,
  lib,
  config,
  modulesPath,
  ...
}:
delib.host {
  name = "thinkpad-e14-gen7";

  system = "x86_64-linux";

  home.home.stateVersion = "25.11";

  nixos = {
    system.stateVersion = "25.11";

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usb_storage"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/769e63fb-d3c5-4819-a5a1-10a2bd0a9cb6";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/9617-D35C";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # nixos-generate-config --show-hardware-config
    # other generated code here...
  };
}
