{ lib, config, ... }:
{
  config.boot.loader.grub = lib.mkIf (config.boot.loader.backend == "grub") {
    enable = true;
    devices = [ "nodev" ];
    extraEntries = lib.mkMerge [
      (builtins.readFile ./40_custom)
    ];
    efiSupport = true;
  };
}
