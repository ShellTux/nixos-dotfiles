{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./loader
  ];

  config = lib.mkIf config.boot.plymouth.enable {
    boot = {
      plymouth = {
        theme = lib.mkDefault "bgrt";
        themePackages = with pkgs; [
          nixos-bgrt-plymouth
          catppuccin-plymouth
        ];
      };

      kernelParams = [
        "quiet"
        "splash"

        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      consoleLogLevel = 0;
      initrd.verbose = false;
      loader.timeout = 3;
    };
  };
}
