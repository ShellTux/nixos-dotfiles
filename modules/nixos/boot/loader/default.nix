{ lib, ... }:
{
  options.boot.loader = {
    backend = lib.mkOption {
      description = "Which backend to use for the bootloader";
      type = lib.types.enum [
        "grub"
        "systemd-boot"
      ];
      default = "grub";
      example = "systemd-boot";
    };
  };

  imports = [
    ./grub
    ./systemd-boot
  ];
}
