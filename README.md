# My-NixOS-journey

https://nixos.org/manual/nixos/stable/#sec-installation
https://github.com/nix-community/disko/blob/master/docs/quickstart.md

## Disko
https://nixos.wiki/wiki/Disko

``` bash
cd /tmp
...
sudo nix --extra-experimental-features nix-command  --extra-experimental-features flakes run github:nix-community/disko -- --mode zap_create_mount ./disk-config.nix
sudo nixos-generate-config --no-filesystems --root /mnt
sudo mv disk-config.nix /mnt/etc/nixos/
nixos-install
reboot
```

## Flakes
https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-configuration-explained