{ delib, inputs, ... }:
delib.host {
  name = "desktop";

  nixos = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                name = "ESP";
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/rootfs" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap = {
                        swapfile.size = "32G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
      nodev = {
        "/tmp" = {
          fsType = "tmpfs";
          mountOptions = [ "size=2G" ];
        };
      };
    };
  };
}
