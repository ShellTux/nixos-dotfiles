{ lib, config, ... }:
{
  config.boot.loader.systemd-boot = lib.mkIf (config.boot.loader.backend == "systemd-boot") {
    enable = true;
  };
}
