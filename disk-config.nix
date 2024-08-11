{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-path/virtio-pci-0000:05:00.0";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/rootfs" = {
                    mountOptions = [ "compress=zstd:3" ];
                    mountpoint = "/";
                  };
                  # Subvolume name is the same as the mountpoint
                  "/home_/current" = {
                    mountOptions = [ "compress=zstd:3" ];
                    mountpoint = "/home";
                  };

                  # Subvolume name is the same as the mountpoint
                  "/home_" = {
                    mountOptions = [ "compress=zstd:3" ];
                    mountpoint = "/home/.snapshots";
                  };

                  # Parent is not mounted so the mountpoint must be set
                  "/nix" = {
                    mountOptions = [ "compress=zstd:3" "noatime" ];
                    mountpoint = "/nix";
                  };

                  # Subvolume for the swapfile
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap = {
                      swapfile.size = "4G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

